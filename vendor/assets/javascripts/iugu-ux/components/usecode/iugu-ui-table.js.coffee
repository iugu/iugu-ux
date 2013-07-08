class IuguUI.Table extends IuguUI.Dataset
  layout: "iugu-ui-table"

  defaults:
    itemLayout: "iugu-ui-table-row"
    itemTagName: "tr"
    itemClassName: "table-row"

  events:
    'click .sort-button' : 'sortByColumn'

  context: ->
    sortableBy: @options.sortableBy
    fields: @options.fields
    sortBy: @sortBy
    identifier: @options.identifier

  initialize: ->
    super
    @sortBy = {}

  sortByColumn: (e) ->
    btn = $(e.currentTarget)
    name = btn.attr('id')

    if btn.data('direction') == "asc"
      btn.data('direction', "")
      delete @sortBy[name]
    else if btn.data('direction') == "desc"
      btn.data('direction', "asc")
      @sortBy[name] = "asc"
    else
      btn.data('direction', "desc")
      @sortBy[name] = "desc"

    @collection.removeFilter 'sortBy'
    @collection.configureFilter 'sortBy', @sortBy
    @collection.fetch()

@IuguUI.Table = IuguUI.Table
