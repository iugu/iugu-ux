class IuguUI.HorizontalSplitView extends IuguUI.View
  layout: "iugu-ui-horizontal-split-view"
  splitSize: "50%"

  initialize: ->
    super
    @

  render: ->
    @extendContextWithSplitOptions()
    super
    @

  extendContextWithSplitOptions: ->
    ctx = @context()
    @context = ->
      _.extend ctx,
        splitSize: @splitSize

  getTopView: ->
    @$('.split-view-top')

  getBottomView: ->
    @$('.split-view-bottom')

  getTopViewClass: ->
    '.split-view-top'

  getBottomViewClass: ->
    '.split-view-bottom'

@IuguUI.HorizontalSplitView = IuguUI.HorizontalSplitView
