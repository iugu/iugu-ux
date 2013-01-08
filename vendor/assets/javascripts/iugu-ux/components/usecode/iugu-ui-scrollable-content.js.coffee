class IuguUI.ScrollableContainer extends IuguUI.Base
  layout: "iugu-ui-scrollable-container"

  getHandler: ->
    @$('.content')

  getContainer: ->
    @$('.handle-scrolling')

  render: ->
    super

@IuguUI.ScrollableContainer = IuguUI.ScrollableContainer
