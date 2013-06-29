class IuguUI.SplitView extends IuguUI.View
  layout: "iugu-ui-split-view"
  split:
    type: "horizontal"
    viewSize: "50%"

  initialize: ->
    super

  render: ->
    @extendContextWithSplitOptions()

  extendContextWithSplitOptions: ->
    ctx = @context()
    @context = ->
      _.extend ctx,
        split: @split
