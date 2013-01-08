class IuguUI.Alert extends IuguUI.Base
  layout: "iugu-ui-alert"

  defaults:
    headerText: "HEADER TEXT"
    bodyText: "BODY TEXT"
    buttonText: "BUTTON TEXT"

  events:
    'click a.alertButton': 'handleDOMEvent'

  context: ->
    headerText: @options.headerText
    bodyText: @options.bodyText
    buttonText: @options.buttonText

@IuguUI.Alert = IuguUI.Alert
