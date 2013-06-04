class IuguUI.Toolbar extends IuguUI.Base
  layout: "iugu-ui-toolbar"
  
  events:
    'click a' : 'buttonClicked'

  initialize: ->
    super
    @

  context: ->
    buttons: @options.buttons

  render: ->
    super
    @

  buttonClicked: (e) ->
    e.preventDefault()
    btn = $(e.currentTarget)
    action = btn.data('action')
    @handleEvent "#{action}:click"

@IuguUI.Toolbar = IuguUI.Toolbar
