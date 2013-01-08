class IuguUI.Table extends IuguUI.Dataset
  layout: "iugu-ui-table"

  defaults:
    itemLayout: "iugu-ui-table-row"
    itemTagName: "tr"
    itemClassName: "table-row"

  events:
    'click a.sort-button' : 'sortByColumn'

  context: ->
    sortableBy: @options.sortableBy
    fields: @options.fields
    sortBy: @sortBy

  initialize: ->
    super
    @sortBy = {}

  sortByColumn: (e) ->
    btn = $(e.target)
    name = btn.context.id

    if btn.data('direction') == "ASC"
      btn.data('direction', "")
      delete @sortBy[name]
    else if btn.data('direction') == "DESC"
      btn.data('direction', "ASC")
      @sortBy[name] = "asc"
    else
      btn.data('direction', "DESC")
      @sortBy[name] = "desc"

    @collection.removeFilter 'sortBy'
    @collection.configureFilter 'sortBy', @sortBy
    @collection.fetch()

@IuguUI.Table = IuguUI.Table
