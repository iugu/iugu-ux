@detectLanguage = ->
  language = window.navigator.userLanguage || window.navigator.language
  language = language.toLowerCase().replace('-','').replace('_','')

@getMousePos = ( event ) ->
  if TOUCH_SUPPORT
    touch = event.originalEvent.touches[0] || event.originalEvent.changedTouches[0]
    cur_x = touch.pageX
    cur_y = touch.pageY
  else
    cur_x = event.clientX
    cur_y = event.clientY
  return { x: cur_x, y: cur_y }

@distanceFrom = ( x, y, x0, y0 ) ->
  Math.sqrt((x -= x0) * x + (y -= y0) * y)

@buildParameters = ( _additional_parameters={} ) ->
  _.extend(
    _additional_parameters
    {
      _t: _t
      i18n: i18n
      _p: _p
    }
  )

@debug = ( text ) ->
  return unless enable_debug
  console.log text

@debug_capabilities = ( )  ->
  debug 'Detected capabilities: ' + $('html').attr('class') + ' ' + navigator.oscpu + ' ' + navigator.platform + navigator.userAgent

String.prototype.capitalize = ->
  @replace( /(^|\s)([a-z])/g , (m,p1,p2) ->
    p1+p2.toUpperCase()
  )

@_callback_xdr = ->
  app.ajax = app._xdr_frame.contentWindow.jQuery.ajax
  app._features['xdr'] = true

@_features_check = ->
  debug 'Waiting featured to be loaded...'
  if _.indexOf(_.values(@app._features),false) != -1
    return
  if @app._features_checker_interval
    clearInterval @app._features_checker_interval
  @app._features_checker_interval = null

  debug 'All featured loaded'

  _.each @app._routers, ( index ) ->
    new index

  if @app.initialize_backbone_history and Backbone.history
    debug 'BackBone History Detected'
    Backbone.history.start({pushState: true, root: @app.root})

@run_webapp = ( run_routes = false ) ->
  debug 'Running Application'

  if app_domain && enable_ajax_on_subdomain
    @app.APP_DOMAIN = app_domain
    document.domain = @app.APP_DOMAIN

  if @app.API_IFRAME
    debug 'Requested API calls inside <iframe>'

  @app._features = {}
  @app._features['xdr'] = true
  @app.ajax = jQuery.ajax

  @app.root = '/'
  if app_root
    @app.root = app_root
    debug 'Custom Application Root Detected: ' + @app.root

  if typeof(subdomain_xdr_url) != 'undefined' && subdomain_xdr_url != ''
    console.log 'Has XDR'
    @app._features['xdr'] = false
    @app._xdr_frame = $('<iframe>').attr('src', subdomain_xdr_url ).load(@_callback_xdr).appendTo('head')[0]

  if run_routes
    @app.initialize_backbone_history = true

  @app._features_checker_interval = setInterval( @_features_check, 250 )
  @_features_check()
  
  debug_capabilities()
