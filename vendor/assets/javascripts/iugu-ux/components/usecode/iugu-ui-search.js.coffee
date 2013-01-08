class IuguUI.Search extends IuguUI.Base

  layout: "iugu-ui-search"

  events:
    'keypress input.search': 'searchCollection'

  searchCollection: (e) ->
    if e.keyCode == 13
      @handleEvent "search"
      e.preventDefault()
      query = $(e.target).val()

      if query == ""
        @collection.removeFilter 'query'
      else
        @collection.configureFilter 'query', query
      @collection.fetch()

  initialize: ->
    _.bindAll @, 'searchCollection'
    super
    @

  render: ->
    super

@IuguUI.Search = IuguUI.Search
