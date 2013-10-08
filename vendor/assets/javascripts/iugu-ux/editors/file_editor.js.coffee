class Backbone.Form.editors.File extends Backbone.Form.editors.Base
  tagName: 'div',

  events:
    change: (evt) ->
      @trigger "change", @

    focus: ->
      @trigger "focus", @

    blur: ->
      @trigger "blur", @

    'click [data-action=remove-document]': 'removeDocument'

  removeDocument: (evt) ->
    evt.preventDefault()
    docid = @$('.uploaded-file').data "id"

    (new DocumentDestroyRequester @, docid).execute()

  removeDocumentDOM: ->
    @$('.uploaded-file').hide()
    @$('.uploaded-file .uploaded-file-name').text ""
    @$('.uploaded-file').data 'id', ""
    @$('.file-upload').show()

  setProgressBar: ( context, value ) ->
    #context.$('.progress .bar').css 'width', value + '%'
    context.$('.progress .bar').text value

  initialize: (options) ->
    Backbone.Form.editors.Base.prototype.initialize.call @, options
    input = @$el.append "<input class='file-upload' type='file'/>"
    prbar = @$el.append "<div class='progress'><div class='bar' style='width: 0%;'></div></div>"
    upfil = @$el.append "<div class='uploaded-file' data-id=''><div class='uploaded-file-name'></div><a data-action='remove-document' href='#'>Remover</a></div>"
    @$('.progress').hide()
    @$('.uploaded-file').hide()

    @on "destroyDocument:done", @removeDocumentDOM, @

    that = @

    @$('.file-upload').fileupload
      url: "/proxy/documents"
      type: "POST"
      dataType: "json"
      formData:
        title: that.schema.title
        api_token: window.api_token
      maxFileSize: 2000000
      progressall: (evt, data) ->
        progress = "Enviando..."
        that.setProgressBar that, progress

      error: ->
        that.removeDocumentDOM()
        that.$('.progress').hide()
        alert("Não foi possível enviar o arquivo.")

      send: (evt, data) ->
        that.$('.file-upload').hide()
        that.$('.progress').show()

      done: (evt, data) ->
        that.setProgressBar that, "100"
        that.$('.progress').hide()
        that.$('.uploaded-file').show()
        that.$('.uploaded-file .uploaded-file-name').text data.result.file_file_name
        that.$('.uploaded-file').data 'id', data.result.id

  render: ->
    @setValue(@value)

    @

  getValue: ->
    @$('.uploaded-file').data 'id'

  setValue: (value) ->
    return unless value
    sp = value.split ":"
    @$('.uploaded-file').data 'id', sp[0]

    if sp.length > 1
      @$('.uploaded-file .uploaded-file-name').text sp[1]
      @$('.progress').hide()
      @$('.file-upload').hide()
      @$('.uploaded-file').show()

  focus: ->
    return if @hasFocus

  blur: ->
    return unless @hasFocus

    @$el.blur()
