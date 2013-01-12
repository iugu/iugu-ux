class ManagedRequest
  defaults:
    type: "GET"
    url: ""
    name: "managedRequest"

  parseResponse: (jqXHR) ->
    obj = {}
    obj.responseText = jqXHR.responseText
    obj.responseStatus = jqXHR.status
    try
      obj.data= JSON.parse( jqXHR.responseText )
    catch error
      obj.data= {}
    obj

  constructor: ( options ) ->
    @options = _.extend {}, @defaults, @options, options
    @requester = Backbone.ajax
    @requester = @options.ajax if @options.ajax

    @trigger = () ->
      debug "NO TRIGGER"

    if @options.context and @options.context.trigger
      @trigger = @options.context.trigger
      @trigger = _.bind(@options.context.trigger,@options.context)

    _.bindAll @

  execute: ->
    app.ajaxSetup
      headers:
        Authorization: $.base64.encode api_token

    @requester
      type: @options.type
      url: @options.url
      data: @options.data
      success: @success
      error: @error
      complete: @complete

  success: (data, textStatus, jqXHR) ->
    if data.errors
      @trigger "#{@options.name}:fail", @parseResponse( jqXHR )
    else
      @trigger "#{@options.name}:done", @parseResponse( jqXHR )
  error: (jqXHR, textStatus, errorThrown) ->
    @trigger "#{@options.name}:fail", @parseResponse( jqXHR )
  complete: (jqXHR, textStatus, errorThrown) ->
    @trigger "#{@options.name}:all", @parseResponse( jqXHR )

@ManagedRequest = ManagedRequest
