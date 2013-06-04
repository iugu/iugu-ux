class IuguUI.Base extends Backbone.View

  defaults:
    baseURL: ""

  initialize: ->
    _.bindAll @

    @options = _.extend {}, @defaults, @options

    @layout = @options.layout if @options.layout
    @parent = @options.parent if @options.parent
    @context = @options.context if @options.context
      
    @identifier = ( -> @options.identifier + ':' ) if @options.identifier

    @handleEvent 'initialize'

    @

  handleDeprecated: ->
    if window.app._iscroll_instances == undefined
      window.app._iscroll_instances = []

    unless window.IS_DEPRECATED_ANDROID
      return

    @$(".handle-scrolling").each( (index,handle_scrolling_elm) ->
      elm = handle_scrolling_elm.parentNode
      if $(handle_scrolling_elm).attr("initialized") != true
        $(handle_scrolling_elm).css('overflow-y','visible')
        $(handle_scrolling_elm).css('height','auto')
        $(handle_scrolling_elm).attr("initialized",true)
        window.app._iscroll_instances.push( new iScroll( elm, { hideScrollbar: false, hScroll: false } ) )
    )

  render: ->
    $(@el).html @getLayout() @context()

    if @className
      $(@el).addClass @className

    @handleDeprecated()

    if window.app._iscroll_instances
      for iscroll in window.app._iscroll_instances
        if iscroll.wrapper
          iscroll.refresh()

    @

  renderPartial: ( layout, target, context=@context ) ->
    $(target).html @getLayout(target) context

    @handleDeprecated()

  getLayout: (layout_file=@layout) ->
    if JST[ "web-app/presenters/" + layout_file ]
      return JST[ "web-app/presenters/" + layout_file ]
    JST[ "iugu-ux/components/presenters/" + layout_file ]

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
    if enable_debug_events? && enable_debug_events
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
