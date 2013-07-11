window.app.BaseResources = Backbone.Paginator.requestPager.extend

  initialize: ->
    @server_api =
      'limit': ->
        return @perPage

      'start': ->
        return (@currentPage - 1) * @perPage

      'api_token': ->
        return api_token

  paginator_ui:
    firstPage: 1
    currentPage: 1
    perPage: 30

  configureFilter: ( param, value ) ->
    @server_api[param] = value
    @trigger 'configured-filter', param

  configureAjax: ->
    app.ajaxSetup
      headers:
        Authorization: $.base64.encode api_token

  getFilter: (param) ->
    @server_api[param]

  removeFilter: (param) ->
    delete @server_api[param]
    @trigger "removed-filter:#{param}"

  removeFiltersEndingWith: (param) ->
    self = @
    _.each @server_api, (value, key) ->
      _regex = new RegExp( "#{param}$")
      self.removeFilter(key) if key.match(_regex)

  parse: (response) ->
    @totalRecords = response.totalItems
    @facets = response.facets
    @totalPages = Math.ceil(@totalRecords / @perPage)
    return response.items || response

  buildChangedPageEventOptions: ->
    that = @
    success: ( ( collection, response ) ->
      that.trigger 'changed-page:success'
    )
    error: ( ( collection, response ) ->
      that.trigger 'changed-page:error'
    )

  gotoFirst: ->
    @goTo @information.firstPage, @buildChangedPageEventOptions()

  gotoLast: ->
    @goTo @information.lastPage, @buildChangedPageEventOptions()

  gotoPage: ( page ) ->
    @goTo page, @buildChangedPageEventOptions()

  gotoNext: ->
    if @information.currentPage < @information.lastPage
      @requestNextPage @buildChangedPageEventOptions()

  gotoPrevious: ->
    if @information.currentPage > 1
      @requestPreviousPage @buildChangedPageEventOptions()

  disablePagination: () ->
    # 64 Bit Integer Size
    @perPage = 9223372036854775807

  destroy: (object) ->
    if object.id?
      object.set '_destroy', true
      @trigger 'remove'
    else
      @remove object
