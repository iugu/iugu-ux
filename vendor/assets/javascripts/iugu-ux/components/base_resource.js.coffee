class window.app.BaseResource extends Backbone.AssociatedModel
  virtual_attributes: []

  initialize: ->
    _.each @relations, (relation) ->
      if relation.type == "Many"
        #@generateDefaults relation
        @generateTriggers relation
        @generateAddFunction relation
        @generateRemoveFunction relation
    , @

    super

    @

  generateDefaults: (relation) ->
    @set("#{relation}", []) unless @get("#{relation}")
    console.log @get("#{relation}")

  generateTriggers: (relation) ->
    @get("#{relation.key}").on 'add', ->
      @trigger "change:#{relation.key}"
    , @
    @get("#{relation.key}").on 'remove', ->
      @trigger "change:#{relation.key}"
    , @
    @on 'sync', ->
      @get("#{relation.key}").on 'add', ->
        @trigger "change:#{relation.key}"
      , @
      @get("#{relation.key}").on 'remove', ->
        @trigger "change:#{relation.key}"
      , @

  generateAddFunction: (relation) ->
    name = relation.key
    name = name.substr(0,1).toUpperCase() + name.substr(1).toLowerCase()
    @["addTo#{name}"] = ->
      @get(relation.key).push new relation.relatedModel

  generateRemoveFunction: (relation) ->
    name = relation.key
    name = name.substr(0,1).toUpperCase() + name.substr(1).toLowerCase()
    @["removeFrom#{name}"] = (object) ->
      @get(relation.key).destroy(object)

  sync: (method, model, options) ->
    @configureAjax()
    Backbone.sync method, model, options

  toJSON: (options) ->
    _.omit( _.clone( super(options) ), @virtual_attributes )
  
  url: ->
    base = super
    base = @appendLocaleInfo(base)

  configureAjax: ->
    app.ajaxSetup
      headers:
        Authorization: $.base64.encode api_token

  appendLocaleInfo: (uri) ->
    uri + (if uri.indexOf('?') then '?' else '&') + 'hl=' + encodeURIComponent( i18n.locale )
