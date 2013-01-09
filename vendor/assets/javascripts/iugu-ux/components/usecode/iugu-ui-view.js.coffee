class IuguUI.View extends IuguUI.Base
  layout: "iugu-ui-view"

  initialize: ->
    if @model
      Backbone.Validation.bind @,
        forceUpdate: true

        valid: (view, attr, selector) ->
          view.valid view, attr, selector

        invalid: (view, attr, error, selector) ->
          view.invalid view, attr, error, selector

      @model.on 'error', @addErrors, @

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

    if app.activeView != @
      app.activeView.close() if app.activeView
      app.activeView = @

    if window.Root.setTitle
      window.Root.setTitle @viewTitle

    @

  unload: () ->
    super
    debug 'Called IuguUI.View:close'
    if @model
      Backbone.Validation.unbind @
      @model.off null, null, @
    if @collection
      @collection.off null, null, @

@IuguUI.View = IuguUI.View
