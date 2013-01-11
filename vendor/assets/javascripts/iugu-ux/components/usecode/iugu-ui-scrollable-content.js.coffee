class IuguUI.ScrollableContainer extends IuguUI.Base
  layout: "iugu-ui-scrollable-container"

  getHandler: ->
    @$('.content:first')

  getContainer: ->
    @$('.handle-scrolling:first')

  render: ->
    super

@IuguUI.ScrollableContainer = IuguUI.ScrollableContainer
