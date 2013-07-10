class _i18n
  locale: "en"

  setDefaultLocale: ( _locale ) ->
    debug 'Configuring Language: ' + _locale
    @locale = _locale
    IuguUI.Money.configureLocale( _locale.toLowerCase() )

  getText: ( _string, _locale = "" ) ->
    _locale = @locale if _locale == ""
    parts = _string.split('.')
    _translated_text = null
    unless AVAILABLE_LOCALES[ _locale ]
      debug "ERROR.I18N.TRANSLATE_TABLE.LOCALE_NOT_EXISTS " + _locale
      return "ERROR.I18N.TRANSLATE_TABLE.LOCALE_NOT_EXISTS"
    currentSegment = AVAILABLE_LOCALES[ _locale ]
    while parts.length
      _next = parts.shift()
      unless currentSegment[ _next ]
        debug "ERROR.I18N.TRANSLATE_TABLE.INVALID_SEGMENT " + _next
        return "ERROR.I18N.TRANSLATE_TABLE.INVALID_SEGMENT"
      currentSegment = currentSegment[ _next ]
    if typeof currentSegment != "string"
      debug "ERROR.I18N.TRANSLATE_TABLE.SEGMENT_NOT_TEXT"
      return "ERROR.I18N.TRANSLATE_TABLE.SEGMENT_NOT_TEXT"
    currentSegment

  pluralizeIf: ( _qty, _singular, _plural, _locale = "" ) ->
    return @getText( _singular, _locale ) if _qty == 1
    @getText( _plural, _locale )

@i18n = new _i18n
@_t = _.bind( @i18n.getText, @i18n )
@_p = _.bind( @i18n.pluralizeIf, @i18n )

# $ ->
#  saved_locale = $.cookie( 'default_locale' )
#  i18n.setDefaultLocale( saved_locale ) if saved_locale
