MainRouter = Backbone.Router.extend
  initialize: ->
    window.app.rootWindow = new window.RootView()
    window.app.rootWindow.render() if window.app.rootWindow

  routes:
    ""                        : "index"
    "/"                       : "index"

  clearView: () ->
    if @aView
      $(@aView.el).empty()
      @aView = undefined

  index: ->
    @clearView()

$ ->
  app.registerRouter( MainRouter )
