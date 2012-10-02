RootView = Backbone.View.extend
  el: "#app"
  initialize: ->
    _.bindAll @, 'render'

  render: ->
    $(@el).html JST["web-app/views/main-view"]

    @

@RootView = RootView
