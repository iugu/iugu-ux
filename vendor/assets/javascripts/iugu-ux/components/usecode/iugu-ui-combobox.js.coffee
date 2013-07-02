class IuguUI.Combobox
  defaults:
    none: false
    displayCurrentSelection: false
    markSelected: false

  el: undefined

  @load: ( context ) ->
    selector = "[data-type='iux.form.combobox']"
    if context
      elements = context.find(selector)
    else
      elements = $(selector)

    return if elements.length == 0
    
    elements.each ->
      return if $(@).data("iux.initialized") == true
      
      new IuguUI.Combobox
        el: @

      $(@).data "iux.initialized", true

  constructor: ( options ) ->
    @initialize( options )

  prepare_select: ->

    if IS_DESKTOP
      # Convert to DIV (Only in Desktop) or USE as DIV (If not select, normal render)

      @input_holder = @el
      @input_holder.on "change", @change_select

      @caller_element = $('<a>',
        html: @input_holder.find("option:selected").text()
        "data-value": @input_holder.find("option:selected").val()
      )

      @root_element = $('<div>',
        "data-display-selection": true
        "data-mark-selected": true
      )

      ul_element = $('<ul>')

      @input_holder.find("option").each ->
        item_element = $('<a>',
          "data-value": $(@).val()
          html: $(@).text()
        )
        ul_element.append item_element

      @root_element.append @caller_element
      @root_element.append ul_element

      @root_element.insertAfter(@input_holder)

      @input_holder.hide()

      @el = @root_element

      @mark_selected()
    else
      @el.addClass("combobox_native") unless @el.hasClass("combobox_native")
      @input_holder = @el
      @input_holder.on "change", @change_select

      @options.displayCurrentSelection = false

      @options.markSelected = false

  initialize: ( options ) ->
    _.bindAll @
    @options = _.extend {}, @defaults, options


    return null unless @options.el

    # Change EL to INPUT (Remember that DIV is also a input)
    @el = $(@options.el) if @options.el

    @prepare_select() if @el.is("select")

    @options.displayCurrentSelection = true if @el.data("display-selection") == true
    @options.markSelected = true if @el.data("mark-selected") == true

    @el.addClass("combobox") unless @el.hasClass("combobox") and @el != @input_holder

    if @el != @input_holder
      @configure_combobox_events()

    @el

  configure_combobox_events: ->
    @menu_element = @el.find("ul")
    return unless @menu_element

    @caller_element = @el.find("> a")
    @caller_element.bind "click", @toggle_menu

    that = @
    @el.find("ul a").bind "click", ( evt ) ->
      that.change $(this).data("value"), $(this).html()

  toggle_menu: ->
    @el.toggleClass("open")

  change_select: ->
    @change @input_holder.val(), @input_holder.find("option:selected").text()

  mark_selected: ->
    @el.find("ul a").removeClass("selected")
    @el.find('ul [data-value="' + @caller_element.data("value") + '"]').addClass("selected")

  change: ( value, title ) ->


    if @options.displayCurrentSelection
      @caller_element.html title

    if value != undefined

      if @el != @input_holder

        @caller_element.data("value", value)

        if @options.markSelected
          @mark_selected()

      if @input_holder and @input_holder.is("select") and value != @input_holder.find("option:selected").val()
        @input_holder.val(value)

    @close_menu()

  close_menu: ->
    @el.removeClass("open")


@IuguUI.Combobox = IuguUI.Combobox

$ ->
  IuguUI.Combobox.load()

