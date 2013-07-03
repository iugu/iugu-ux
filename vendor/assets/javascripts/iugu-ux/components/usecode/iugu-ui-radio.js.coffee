class IuguUI.Radio
  defaults:
    none: false

  el: undefined

  @load: ( context ) ->
    selector = "[data-type='iux.form.radio']"
    if context
      elements = context.find(selector)
    else
      elements = $(selector)

    return if elements.length == 0
    
    elements.each ->
      return if $(@).data("iux.initialized") == true

      new IuguUI.Radio
        el: @

      $(@).data "iux.initialized", true

  constructor: ( options ) ->
    @initialize( options )
  
  initialize: ( options ) ->
    _.bindAll @
    @options = _.extend {}, @defaults, options

    return null unless @options.el

    @el = $(@options.el) if @options.el

    radio_classes = "radio"

    @decorator = $('<a>',
      class: radio_classes + ( if @el.is(":checked") then ' selected' else '')
      html: '<div class="outer_decorator"><div class="inner_decorator"></div></div>'
      "data-mode": "toggle"
      "data-input": @el.attr("id")
      "data-group": @el.attr("name")
    )

    @decorator.insertAfter( @el )

    new IuguUI.Button
      el: @decorator
      context: @el

@IuguUI.Radio = IuguUI.Radio

$ ->
  IuguUI.Radio.load()

