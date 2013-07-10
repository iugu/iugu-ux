class window.app.BaseResource extends Backbone.AssociatedModel
  virtual_attributes: []

  initialize: ->
    _.each @relations, (relation) ->
      if relation.type == "Many"
        @generateDefaults relation
        @generateTriggers relation
        @generateAddFunction relation
        @generateRemoveFunction relation
    , @

    super

    @

  generateDefaults: (relation) ->
    @set("#{relation.key}", []) unless @get("#{relation.key}")

  generateEvent: (on_event, key, context) ->
    @get(key).on on_event, ->
      @trigger "change:#{key}"
    , context

  generateTriggers: (relation) ->
    @generateEvent 'add', relation.key, @
    @generateEvent 'remove', relation.key, @

    @on 'sync', ->
      @generateEvent 'add', relation.key, @
      @generateEvent 'remove', relation.key, @
    , @

  properCasedRelationName: (key) ->
    key.substr(0,1).toUpperCase() + key.substr(1).toLowerCase()

  generateAddFunction: (relation) ->
    @["addTo#{@properCasedRelationName relation.key}"] = ->
      @get(relation.key).push new relation.relatedModel

  generateRemoveFunction: (relation) ->
    @["removeFrom#{@properCasedRelationName relation.key}"] = (object) ->
      @get(relation.key).destroy(object)

  sync: (method, model, options) ->
    @configureAjax()
    Backbone.sync method, model, options

  toJSON: (options) ->
    _.omit( _.clone( super(options) ), @virtual_attributes )
  
  url: ->
    base = super
    base = @appendLocaleInfo(base)

  save: (attributes, options) ->
    if @isValid(true)
      super null, @handleViewContext options

  handleViewContext: (options) ->
    return options unless options.context
    options.context.enableLoader()
    options.wait = true
    options.complete = (jqXHR, textStatus) ->
      return options.context.disableLoader() unless textStatus == "success"

      if options.elastic_delay is on
        setTimeout( ->
          options.context.disableLoader()
          options.context.redirectBack() unless options.callbackView
        , 1000)
      else
        options.context.disableLoader()
        options.context.redirectBack() unless options.callbackView
    options

  destroy: (options) ->
    super @handleViewContext options

  configureAjax: ->
    app.ajaxSetup
      headers:
        Authorization: $.base64.encode api_token

  appendLocaleInfo: (uri) ->
    uri + (if uri.indexOf('?') then '?' else '&') + 'hl=' + encodeURIComponent( i18n.locale )
