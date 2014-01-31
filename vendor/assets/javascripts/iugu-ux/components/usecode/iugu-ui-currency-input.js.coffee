class IuguUI.Money
  defaults:
    none: false
    hideInput: true

  el: undefined

  @fromCentsToMoney: ( cents, locale ) ->
    cents = (cents / 100).toFixed(2)
    numeral( cents ).format("$0,0.00")

  @fromMoneyToCents: ( currency, locale ) ->
    value = numeral().unformat( currency )
    (value * 100).toFixed(0)

  @configureLocale: ->
    numeral.language( i18n.locale.toLowerCase() )

  @load: ( context ) ->
    selector = "[data-type='iux.form.money_input']"
    if context
      elements = context.find(selector)
    else
      elements = $(selector)

    return if elements.length == 0
    
    elements.each ->
      return if $(@).data("iux.initialized") == true

      new IuguUI.Money
        el: @
        context: context

      $(@).data "iux.initialized", true

  maskOptions: ->
    if i18n.locale.toLowerCase() == "pt-br"
      {prefix: 'R$', thousands:'.', decimal: ","}
    else
      {prefix: '$', thousands:',', decimal: "."}


  constructor: ( options ) ->
    @initialize( options )
  
  initialize: ( options ) ->
    _.bindAll @
    @options = _.extend {}, @defaults, options

    return null unless @options.el

    @el = $(@options.el)

    @input_element = @el

    @decorator = $('<input>',
      type: "text"
      placeholder: @input_element.attr "placeholder"
      value: @input_element.attr "value"
      class: @input_element.attr "class"
    )

    @decorator.maskMoney(@maskOptions())

    @decorator.insertAfter( @el )

    that = @

    @decorator.bind "focus", ->
      $(this).maskMoney('mask')

    @decorator.bind "blur", ->
      that.input_element.val($(this).val().replace(/[^0-9]/g, ''))
      that.input_element.trigger('change')

    @decorator.val( that.input_element.val() )
    @decorator.maskMoney('mask')

    @input_element.hide()

  getInput: ->
    return $(@input_element) if @input_element
    false

  configureInputElementValue: ( value ) ->
    return unless @getInput()

    @getInput().val( value ) if @getInput()

    if (@getInput())
      @getInput().trigger("change")

@IuguUI.Money= IuguUI.Money

$ ->
  IuguUI.Money.load()
