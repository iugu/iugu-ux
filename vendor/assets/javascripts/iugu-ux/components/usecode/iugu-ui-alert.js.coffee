class IuguUI.Alert extends IuguUI.Base
  layout: "iugu-ui-alert"

  defaults:
    headerText: "HEADER TEXT"
    alertClass: "notice-green"

  events:
    'click a.alertButton': 'handleDOMEvent'

  context: ->
    headerText: @options.headerText
    bodyText: @options.bodyText
    buttonText: @options.buttonText
    alertClass: @options.alertClass

@IuguUI.Alert = IuguUI.Alert
