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
    range: true
    min: 0
    max: 500
    values: [ 75, 300 ]
  )
