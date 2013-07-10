class IuguUI.ResponsiveBox extends IuguUI.Base
  layout: "iugu-ui-responsive-box"

  defaults:
    sidebar: null

  # TODO: Improve wrappers
  initialize: ->
    _.bindAll @, 'toggleSidebar'
    @sidebar = @options.sidebar
    @sidebar = new IuguUI.ScrollableContainer() unless @sidebar
    @content = new IuguUI.ScrollableContainer()
    @sidebar_wrapper = null
    @content_wrapper = null
    @views = []

  getSidebarWrapper: ->
    @sidebar_wrapper

  getSidebar: ->
    @sidebar

  getContent: ->
    @content.getContainer()

  setTitle: (title) ->
    @$('.responsive-title').html(title)

  getTitle: ->
    @$('.responsive-title').html()

  pushRootView: (view) ->
    debug "PUSH ROOT VIEW"
    @views = []
    @pushView view

  pushView: (view) ->
    debug "PUSH VIEW"
    @views.push view
    @getContent().html view.el

  popView: (data = null) ->
    debug "POP VIEW"
    lastView = _.last @views
    @views.pop()

    view = _.last @views
    if view
      @getContent().html view.el
      view.trigger lastView.identifier() + "pop", data

  disableFeedback: ->
    uibox = @$('.ui-responsive-box')

    preventContainer = $(document.createElement('div'))
    preventContainer.css('position','absolute')
    preventContainer.css('width','100%')
    preventContainer.css('height','100%')
    preventContainer.css('left','0px')
    preventContainer.css('top','0px')
    preventContainer.css('backgroundColor','transparent')
    preventContainer.css('z-index','5000')
    uibox.append(preventContainer)
    setTimeout(
      () ->
        preventContainer.remove()
      , 500
    )

  hasMovableSidebar: ->
    uibox = @$('.ui-responsive-box')

    uisidebar = uibox.children('.sidebar')
    if ( uisidebar.css('z-index') != '1000' )
      return false

    true

  configureDisplayForSidebar: (type) ->
    uibox = @$('.ui-responsive-box')
    return unless uibox
    switch type
      when "open"
        uibox.addClass('open') unless uibox.hasClass('open')
      when "close"
        uibox.removeClass('open') if uibox.hasClass('open')
      else
        uibox.toggleClass('open')


  toggleSidebar: ( evt ) ->
    evt.preventDefault() if evt

    return unless @hasMovableSidebar()

    @disableFeedback()
    @configureDisplayForSidebar "toggle"

  openSidebar: ( evt ) ->
    evt.preventDefault() if evt

    return unless @hasMovableSidebar()

    @disableFeedback()
    @configureDisplayForSidebar "open"

  closeSidebar: ( evt ) ->
    evt.preventDefault() if evt

    return unless @hasMovableSidebar()

    @disableFeedback()
    @configureDisplayForSidebar "close"

  render: ->
    super
    $(document.body).addClass 'ui-box-background'

    @sidebar_wrapper = $(document.createElement('div'))
    @content_wrapper = $(document.createElement('div'))
    @sidebar_wrapper.addClass "sidebar"
    @content_wrapper.addClass "content-area handle-sidebar"

    small_navigation = $(document.createElement('div'))
    small_navigation.addClass 'small-navigation'
    small_navigation.html '<div class="toggle-sidebar"><div class="iux-default-menu-icon"></div></div><div class="responsive-title"></div>'

    @sidebar.setElement(@sidebar_wrapper).render()
    @content.setElement(@content_wrapper).render()
    @content_wrapper.append small_navigation

    @$('.ui-responsive-box').append @sidebar_wrapper, @content_wrapper

    that = @
    if window.TOUCH_SUPPORT
      @$('.toggle-sidebar').bind 'touchstart', that.toggleSidebar
    else
      @$('.toggle-sidebar').bind 'click', that.toggleSidebar
    @

@IuguUI.ResponsiveBox = IuguUI.ResponsiveBox
