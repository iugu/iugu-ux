class IuguUI.Button
  defaults:
    none: false
    hideInput: true

  el: undefined

  @load: ( context ) ->
    selector = "[data-type='iux.form.button']"
    if context
      elements = context.find(selector)
    else
      elements = $(selector)

    return if elements.length == 0
    
    elements.each ->
      return if $(@).data("iux.initialized") == true

      new IuguUI.Button
        el: @
        context: context

      $(@).data "iux.initialized", true

  constructor: ( options ) ->
    @initialize( options )
  
  initialize: ( options ) ->
    _.bindAll @
    @options = _.extend {}, @defaults, options

    return null unless @options.el

    @el = $(@options.el)

    @toggle_button = true if @el.data("mode") == "toggle"
    @onClick = @options.onClick if @options.onClick

    input_selector = ("#" + @el.data("input")) if @el.data("input")
    if @options.context and input_selector
      @input_element = $(@options.context.find(input_selector))
      if @input_element.size() == 0
        @input_element = @options.context
      @input_element = $(@input_element[0])
    else if input_selector
      @input_element = $(input_selector)

    if @getInput() and @el.data("value") and @el.data("value").toString() == @getInput().val().toString()
      @el.addClass("selected") unless @el.hasClass("selected")

    if @getInput() and @getInput().is(":checkbox") and @getInput().is(":checked")
      @el.addClass("selected")


    if @getInput() and @getInput().is(":radio") and @getInput().is(":checked")
      @el.addClass("selected")

    if @getInput() and @getInput().is(":radio") or @getInput().is(":checkbox")
      @getInput().bind "change", @inputChangedCallback

    @el.bind "click", @click

    if @options.hideInput and @input_element
      @input_element.hide()

  getInput: ->
    return $(@input_element) if @input_element
    false

  linkedElements: ->
    $('[data-group="' + @el.data("group") + '"]')

  hasLinkedElements: ->
    elms = @linkedElements()
    return false unless elms and elms.size() > 1
    true

  inputChangedCallback: ->
    if @hasLinkedElements()
      @linkedElements().removeClass("selected")

    if @getInput() and @getInput().is(":checkbox") and @getInput().is(":checked")
      @el.addClass("selected")

    if @getInput() and @getInput().is(":radio") and @getInput().is(":checked")
      @el.addClass("selected")

  configureInputElementValue: ( value ) ->
    return unless @getInput()

    if @getInput().is(":checkbox")
      @getInput().attr "checked", @el.hasClass("selected")
    else if @getInput().is(":radio")
      @getInput().attr "checked", @el.hasClass("selected")
    else
      @getInput().val( value ) if @getInput()

    if (@getInput())
      @getInput().trigger("change")

  toggleable: ->
    return false unless @toggle_button
    return false if @hasLinkedElements()
    true

  click: ->
    value = @el.data("value") if @el.data("value")

    if @toggleable()
      @el.toggleClass "selected"

    if @toggleable() and @el.hasClass("selected") == false
      value = null

    if @hasLinkedElements()
      @linkedElements().removeClass("selected")
      @el.addClass("selected")

    if value != null
      # Configure value
      @onClick( value ) if @onClick

      @configureInputElementValue value
    else
      @configureInputElementValue value

@IuguUI.Button = IuguUI.Button

$ ->
  IuguUI.Button.load()
