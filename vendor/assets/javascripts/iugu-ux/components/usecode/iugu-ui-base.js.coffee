class IuguUI.Base extends Backbone.View

  defaults:
    baseURL: ""

  initialize: ->
    _.bindAll @, 'render', 'root', 'identifier', 'delegateChild', 'mapDOMEvent', 'handleEvent', 'handleDOMEvent', 'unload', 'close'

    @options = _.extend {}, @defaults, @options

    @layout = @options.layout if @options.layout
    @parent = @options.parent if @options.parent
    
    @identifier = ( -> @options.identifier + ':' ) if @options.identifier

    @handleEvent 'initialize'

    @

  render: ->
    $(@el).html @getLayout() @context()

    if @className
      $(@el).addClass @className

    @

  getLayout: ->
    if JST[ "web-app/presenters/" + @layout ]
      return JST[ "web-app/presenters/" + @layout ]
    JST[ "iugu-ux/components/presenters/" + @layout ]

  context: ->
    return { }

  historyNavigate: (url) ->
    Backbone.history.navigate @options.baseURL + '/' + url

  root: ->
    _.result(@parent,'root') or @

  identifier: ->
    _.result(@parent,'identifier') or ''

  delegateChild: ( selector, view ) ->
    selectors = {}
    if _.isObject(selector)
      selectors = selector
    else
      selectors[selector] = view
    return unless selectors
    _.each( selectors, ( view, selector ) ->
      view.setElement(@$(selector)).render()
    , this )

  mapDOMEvent: (type) ->
    switch type
      when 'click' then return 'click'
      when 'mouseover' then return 'mouseover'
      when 'mouseout' then return 'mouseout'
      else return type

  handleEvent: (triggerType) ->
    @root().trigger( @identifier() + triggerType, @ )

  handleDOMEvent: (e) ->
    e.preventDefault()
    triggerType = @mapDOMEvent e.type
    @handleEvent triggerType

  trigger: (events) ->
    if app.debug_events
      debug 'Triggered Event: ' + arguments[0]
    super

  unload: () ->
    debug 'Called IuguUI.Base:unload'
    @undelegateEvents()
    @off()

  close: () ->
    debug 'Called IuguUI.Base:close'
    if @className
      $(@el).removeClass @className
    @unload()
    @remove()

@IuguUI.Base = IuguUI.Base
