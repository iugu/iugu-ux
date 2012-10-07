MainRouter = Backbone.Router.extend
  initialize: ->
    window.Root = new window.RootView()
    window.Root.render() if window.Root

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
