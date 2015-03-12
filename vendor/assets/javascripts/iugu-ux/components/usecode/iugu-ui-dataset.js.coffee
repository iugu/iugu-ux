class IuguUI.Dataset extends IuguUI.View
  layout: "iugu-ui-dataset"
  secondaryView: true

  defaults:
    itemLayout: "iugu-ui-dataset-record"
    itemTagName: "div"
    itemClassName: "record"

  initialize: ->
    super
    _.bindAll @, 'renderItems', 'addRecord'

    @collection.on 'fetch', @enableLoader, @
    @collection.on 'reset', @load, @

    @

  addRecord: (item) ->
    @els.push (
      new IuguUI.DatasetRecord
        model: item
        baseURL: @options.baseURL
        layout: @options.itemLayout
        fields: @options.fields
        tagName: @options.itemTagName
        className: @classForItem(item)
        identifier: @identifier() + "record"
        presenter: @options.recordPresenter
        parent: @
    ).render().el

  classForItem: (item) ->
    mod = @options.classModifier(item) if @options.classModifier
    "#{@options.itemClassName} #{mod}"

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
