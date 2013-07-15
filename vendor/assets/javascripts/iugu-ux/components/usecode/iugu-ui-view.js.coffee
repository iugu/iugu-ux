class IuguUI.View extends IuguUI.Base
  layout: "iugu-ui-view"
  secondaryView: false

  initialize: ->
    super

    window.Events.on "fillSlots", @fillSlots
    window.Events.on "resetSlots", @resetSlots

    @defaultLayout = @layout

    @secondaryView = @options.secondaryView if @options.secondaryView

    @firstRender = true

    if @model
      Backbone.Validation.bind @,
        forceUpdate: true

        valid: (view, attr, selector, cid) ->
          view.valid view, attr, selector, cid

        invalid: (view, attr, error, selector, cid) ->
          view.invalid view, attr, error, selector, cid

      @model.on 'error', @addErrors, @

    @

  redirectBack: ->
    history.back()

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
    @viewLoader = $('<div class="viewLoader"><div class="blockLayer"></div><div class="loaderContainer"><img src="/assets/loading.gif" width="32" height="32" /></div></div>')
    $(@el).append @viewLoader

  disableLoader: ->
    debug "DISABLED LOADER"
    if @viewLoader
      @viewLoader.remove()

  load: ->
    debug "ON LOAD"
    @disableLoader()
    @render()

  valid: (view, attr, selector, cid) ->
    sel = '[' + selector + '~="' + attr + '"]'
    sel = sel + '[cid="' + cid + '"]' if cid
    control = view.$ sel
    group = view.$ ".form-group"
    list = group.find ".error-list"

    return if view.model.preValidate attr, control.val()

    new_attr = attr.replace '.', '-'
    @$(".error-" + new_attr).remove()

    control.parents('.iugu-ui-form-wrapper').removeClass "input-with-errors"

    list.parent().remove() if list.find(".error").length == 0

  invalid: (view, attr, error, selector, cid) ->
    sel = '[' + selector + '~="' + attr + '"]'
    sel = sel + '[cid="' + cid + '"]' if cid
    control = view.$ sel
    group = view.$ ".form-group"
    list = group.find ".error-list"
      
    control.parents('.iugu-ui-form-wrapper').addClass "input-with-errors"

    if list.length == 0
      group.prepend "<div class='notice notice-red'><h4 class='notice-heading'>#{_t 'phrases.error_title'}</h4><ul class='error-list'></ul></div>"
      list = group.find ".error-list"

    new_attr = attr.replace '.', '-'

    list.find(".error-" + new_attr).remove()

    parent_model = ""
    parent_model = "error-" + attr.split('.')[0] if cid?

    model_name = @model.identifier
    right_attr = attr.split '.'
    right_attr = right_attr[right_attr.length-1]

    right_attr = attr unless model_name?

    if _.isArray(error)
      _.each(error, (err) ->
        list.append "<li class='error #{parent_model} error-#{new_attr}'>#{_t(model_name + '_fields.' + right_attr)} #{err}</li>"
      )
    else
      list.append "<li class='error #{parent_model} error-#{new_attr}'>#{error}</li>"


  addErrors: (model, errors) ->
    debug "COCO"
    invalid = @invalid
    view = @

    errors_json = JSON.parse errors.responseText

    _.each(errors_json.errors, (val, key) ->
      invalid view, key, val, "name"
    )

  doEmptyCollectionLogic: ->
    if @collection? && @collection.length == 0
      @layout = @emptyCollection.layout || 'iugu-ui-view-empty'
      @extendContextWithEmptyCollection()
    else
      @layout = @defaultLayout if @defaultLayout?

  extendContextWithEmptyCollection: ->
    ctx = @context()
    @context = ->
      _.extend ctx,
        emptyCollection: @emptyCollection

  render: ->
    if @emptyCollection? && @firstRender
      @doEmptyCollectionLogic()

    @firstRender = false

    super

    @secondaryView = @options.secondaryView if @options.secondaryView?

    if app.activeView != @ and @secondaryView == false
      app.activeView.close() if app.activeView
      app.activeView = @

    if window.app.rootWindow? and window.app.rootWindow.setTitle
      window.app.rootWindow.setTitle @title


    rivets.bind @$el, {model: @model} if @model

    IuguUI.Combobox.load( @$el )

    IuguUI.Button.load( @$el )

    IuguUI.Checkbox.load( @$el )
    IuguUI.Radio.load( @$el )

    IuguUI.Money.load( @$el )


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
