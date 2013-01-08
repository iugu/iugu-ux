class IuguUI.SearchRange extends IuguUI.Base

  layout: "iugu-ui-search-range"

  defaults:
    fieldName: "created_at"

  events:
    'click .search-range-submit': 'searchCollection'

  searchCollection: (e) ->
    e.preventDefault()
    from = $('.search-range-from').val()
    to = $('.search-range-to').val()
    if from == ""
      @collection.removeFilter @options.fieldName + '_from'
    else
      @collection.configureFilter @options.fieldName + '_from', from

    if to == ""
      @collection.removeFilter @options.fieldName + '_to'
    else
      @collection.configureFilter @options.fieldName + '_to', to

    @collection.fetch()

  initialize: ->
    _.bindAll @, 'searchCollection'
    super
    @

  render: ->
    super

@IuguUI.SearchRange = IuguUI.SearchRange
