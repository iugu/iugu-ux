class IuguUI.PopupContainer extends IuguUI.View
  layout: "iugu-ui-popup-container"
  secondaryView: true

  defaults:
    content: null
    width: 320
    height: 480

  context: ->
    width: @options.width
    height: @options.height

  initialize: ->
    _.bindAll @
    super

    @content = new IuguUI.View
      layout: @content
      secondaryView: true

    @content_wrapper = null

  getHandler: ->
    @$('.content:first')

  getContainer: ->
    @$('.container:first')

  render: ->
    super
    unless @content_wrapper
      @content_wrapper = $(document.createElement('div'))

    @content.setElement(@content_wrapper).render()

    @getContainer().html @content_wrapper


    @

@IuguUI.PopupContainer = IuguUI.PopupContainer
