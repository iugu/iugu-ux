class IuguUI.Dataset extends IuguUI.Base
  layout: "iugu-ui-dataset"

  defaults:
    itemLayout: "iugu-ui-dataset-record"
    itemTagName: "div"
    itemClassName: "record"

  initialize: ->
    super
    _.bindAll @, 'renderItems', 'addRecord'
    @collection.on('all', @render)

    @

  addRecord: (item) ->
    @els.push (
      new IuguUI.DatasetRecord
        model: item
        baseURL: @options.baseURL
        layout: @options.itemLayout
        fields: @options.fields
        tagName: @options.itemTagName
        className: @options.itemClassName
        identifier: @identifier() + "record"
        presenter: @options.recordPresenter
        parent: @
    ).render().el

  context: ->
    dataset: @collection
    options: @options

  render: ->
    super
    @renderItems()

    @

  renderItems: ->
    @els = []
    @collection.each @addRecord

    @$('.records').append @els

    @

@IuguUI.Dataset = IuguUI.Dataset
