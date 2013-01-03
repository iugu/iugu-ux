@configure_ui_action = (button,callback=null) ->
  button = $(button)
  if window.IS_MOBILE
    button.on 'touchstart', (evt) ->
      # evt.preventDefault()
      $(@).addClass 'active'
    button.on 'touchend', (evt) ->
      # evt.preventDefault()
      $(@).removeClass 'active'
      callback(evt) if callback
  else
    button.on 'mousedown', (evt) ->
      # evt.preventDefault()
      $(@).addClass 'active'
    button.on 'mouseup', (evt) ->
      # evt.preventDefault()
      $(@).removeClass 'active'
      callback(evt) if callback

@configure_ui_button = (button) ->
  # alert $(button).html()
  debug "Configuring UI Button"
  configure_ui_action button, () ->
    debug "CLICKED OK"

$ ->
  $(".button").each (el) ->
    configure_ui_button @

  $("#slider").slider(
    orientation: "vertical"
    range: true
    min: 0
    max: 500
    values: [ 75, 300 ]
  )

  $("[data-selector]").each (evt) ->
    console.log $(@).data('selector')
    elph = $(@)
    selector_type = elph.data('selector')
    selector_label = elph.data('label')
    console.log selector_label

    if selector_type == 'date'
      console.log "A date selector has been found!"
      component = $(@).mobiscroll().date({
        label: selector_label
        theme: 'ui-selector date'
        display: 'inline'
        mode: 'scroller'
        inputClass: "ui-selector-input-hidden"
      })
      console.log "OK"
      newdiv = $(document.createElement('div'))
      newdiv.html '<span>' + selector_label + '</span>'
      newdiv.addClass "ui-selector-floating-title"
      newdiv.insertAfter(elph)

    else if selector_type == 'select'
      console.log "A selector has been found!"
      $(@).mobiscroll().select({
        label: selector_label
        theme: "ui-selector"
        display: "inline"
        mode: "scroller"
        inputClass: "ui-selector-input-hidden"
      })


