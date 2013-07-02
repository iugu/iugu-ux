class IuguUI.Checkbox
  defaults:
    none: false

  el: undefined

  @load: ( context ) ->
    selector = "[data-type='iux.form.checkbox']"
    if context
      elements = context.find(selector)
    else
      elements = $(selector)

    return if elements.length == 0
    
    elements.each ->
      return if $(@).data("iux.initialized") == true

      new IuguUI.Checkbox
        el: @

      $(@).data "iux.initialized", true

  constructor: ( options ) ->
    @initialize( options )
  
  initialize: ( options ) ->
    _.bindAll @
    @options = _.extend {}, @defaults, options

    return null unless @options.el

    @el = $(@options.el) if @options.el

    checkbox_classes = "checkbox"

    label_on = if @el.data("on") then @el.data("on") else undefined
    label_off = if @el.data("off") then @el.data("off") else undefined

    if @el.data("mode") == "switch"
      checkbox_classes = " switch"

    optional_labels = ""

    optional_labels += '<div class="label_decorator_on"> ' + label_on + '</div>' if label_on
    optional_labels += '<div class="label_decorator_off"> ' + label_off + '</div>' if label_off

    @decorator = $('<a>',
      class: checkbox_classes + ( if @el.is(":checked") then ' selected' else '')
      html: '<div class="outer_decorator"><div class="inner_decorator"></div>' + optional_labels + '</div>'
    )

    @decorator.bind 'click', @toggle
    @el.bind 'change', @toggle

    @decorator.insertAfter( @el )

    @el.hide()

  toggle: ->
    @decorator.toggleClass "selected"
    isChecked = @decorator.hasClass "selected"
    @el.attr "checked", isChecked

@IuguUI.Checkbox = IuguUI.Checkbox

$ ->
  IuguUI.Checkbox.load()

