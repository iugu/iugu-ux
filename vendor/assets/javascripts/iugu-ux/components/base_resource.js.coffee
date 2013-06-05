class window.app.BaseResource extends Backbone.AssociatedModel
  virtual_attributes: []

  sync: (method, model, options) ->
    @configureAjax()
    Backbone.sync method, model, options

  toJSON: (options) ->
    _.omit( _.clone( @attributes ), @virtual_attributes )

  url: ->
    base = super
    base = @appendLocaleInfo(base)

  configureAjax: ->
    app.ajaxSetup
      headers:
        Authorization: $.base64.encode api_token

  appendLocaleInfo: (uri) ->
    uri + (if uri.indexOf('?') then '?' else '&') + 'hl=' + encodeURIComponent( i18n.locale )
