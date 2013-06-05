class IuguUI.View extends IuguUI.Base
  layout: "iugu-ui-view"
  secondaryView: false

  initialize: ->
    super

    window.Events.on "fillSlots", @fillSlots
    window.Events.on "resetSlots", @resetSlots

    @secondaryView = @options.secondaryView if @options.secondaryView

    if @model
      Backbone.Validation.bind @,
        forceUpdate: true

        valid: (view, attr, selector) ->
          view.valid view, attr, selector

        invalid: (view, attr, error, selector) ->
          view.invalid view, attr, error, selector

      @model.on 'error', @addErrors, @

  fillSlots: ( context ) ->
    _.each( _.keys(context)
      ( key ) ->
        renderContext = context[key]
        if renderContext.el
          context[key].$el.detach()
          @$(key).empty().append context[key].el
        else
          @$(key).empty().append context[key]
    )

  resetSlots: ( slots ) ->
    _.each( slots,
      ( slot ) ->
        @$(slot).empty()
    )
    
  enableLoader: ->
    debug "ENABLED LOADER"
    @viewLoader = $('<div style="position:absolute;top:0px;left:0px;width:100%;height:100%;"><div style="position:absolute;left:0px;top:0px;width:100%;height:100%;background:rgba(255,255,255,0.5);z-index:2"></div><div style="position:absolute;top:50%;left:50%;width:64px;height:64px;margin-left:-32px;margin-top:-32px;background:#fff;-moz-border-radius(5px);line-height:64px;text-align:center;color:#fff"><img src="/assets/loading.gif" width="32" height="32" /></div></div>')
    $(@el).append @viewLoader

  disableLoader: ->
    debug "DISABLED LOADER"
    if @viewLoader
      @viewLoader.remove()

  load: ->
    debug "ON LOAD"
    @disableLoader()
    @render()

  valid: (view, attr, selector) ->
    control = view.$ '[' + selector + '=\"' + attr + '\"]'
    group = control.parents ".form-group"
    ctrlGroup = control.parents ".control-group"
    list = group.find ".error-list"

    return if view.model.preValidate attr, control.val()

    list.find(".error-" + attr).remove()

    ctrlGroup.removeClass "error"

    list.parent().remove() if list.find(".error").length == 0

  invalid: (view, attr, error, selector) ->
    control = view.$ '[' + selector + '=\"' + attr + '\"]'
    group = control.parents ".form-group"
    ctrlGroup = control.parents ".control-group"
    list = group.find ".error-list"
      
    ctrlGroup.addClass "error"

    if list.length == 0
      group.prepend '<div class="alert alert-error"><ul class="error-list"></ul></div>'
      list = group.find ".error-list"

    list.find(".error-" + attr).remove()

    if _.isArray(error)
      _.each(error, (err) ->
        list.append '<li class="error error-' + attr + '">' + attr + ' ' + err + '</li>'
      )
    else
      list.append '<li class="error error-' + attr + '">' + error + '</li>'


  addErrors: (model, errors) ->
    invalid = @invalid
    view = @

    errors_json = JSON.parse errors.responseText

    _.each(errors_json.errors, (val, key) ->
      invalid view, key, val, "name"
    )

  render: ->
    super

    rivets.bind this.$el, {model: @model} if @model

    if app.activeView != @ and @secondaryView == false
      app.activeView.close() if app.activeView
      app.activeView = @

    if window.app.rootWindow.setTitle
      window.app.rootWindow.setTitle @title

    @

  unload: () ->
    debug 'Called IuguUI.View:unload'
    if @model
      Backbone.Validation.unbind @
      @model.off null, null, @
    if @collection
      @collection.off null, null, @
    super

@IuguUI.View = IuguUI.View
