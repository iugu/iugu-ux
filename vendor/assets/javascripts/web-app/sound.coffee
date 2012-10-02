class _Sound
  format: if $.browser.webkit then ".mp3" else ".wav"
  soundPath: "/assets/s/"
  sound: []
  environmentSound: null
  maxChannels: 8

  constructor: () ->
    @sound.size = 8
    for i in [0..7]
      @sound[i] = null

  loadSoundChannel: (name) ->
    snd = new Audio( @soundPath + name + @format )
    snd.preload = false
    snd.load()
    snd

  enableDesktopLoop: ( env ) ->
    if typeof env.loop == 'boolean'
      env.loop = true
    else
      env.addEventListener( 'ended',
        () ->
          this.currentTime = 0
          this.play()
        false
      )

  playDesktop: (name, options = {}) ->
    if options.environmentSound
      @environmentSound.stop() if @environmentSound
      @environmentSound = @loadSoundChannel( name )
      @enableDesktopLoop( @environmentSound ) if options.environmentSound
      @environmentSound.play()
      return

    aChannel = false
    for i in [0..8]
      if @sound[i] == null
        aChannel = i
        break
      else if @sound[i] and (@sound[i].currentTime == @sound[i].duration || @sound[i].currentTime == 0)
        aChannel = i
        break

    @sound[ aChannel ] = @loadSoundChannel( name )
    @enableDesktopLoop( @sound[ aChannel ] ) if options.environmentSound
    @sound[ aChannel ].play()

  stopDesktop: (channel) ->
    @sound[channel].stop() if @sound[channel] and (@sound[channel].currentTime == @sound[channel].duration || @sound[channel].currentTime == 0)

  stopEnvironmentDesktop: ->
    @environmentSound.stop() if @environmentSound

  # SUPPORT CORDOVA
  play: (name, options = {}) ->
    @playDesktop name, options unless IS_MOBILE

  stop: (channel) ->
    @stopDesktop channel unless IS_MOBILE

  stopEnvironment: ->
    @stopEnvironmentDesktop() unless IS_MOBILE

window.Sound = new _Sound()
