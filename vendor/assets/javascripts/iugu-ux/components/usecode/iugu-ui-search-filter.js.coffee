class IuguUI.SearchFilter extends IuguUI.Base

  layout: "iugu-ui-search-filter"
  className: "search-filter"

  defaults:
    filterName: "age"
    fixedFilters: []
    multiSelection: false
    translateTerms: false
    translationPrefix: "translation."

  events:
    'click [data-action=search-filter-button]': 'searchCollection'

  searchCollection: (e) ->
    e.preventDefault()
    @handleEvent "facet:click"
    button = $(e.target)
    filter = button.data('filter')
    button.toggleClass('active')

    unless @options.multiSelection
      @selected = []

    unless _.indexOf(@selected, filter.toString()) == -1
      @selected = _.without(@selected, filter.toString())
    else
      @selected.push(filter.toString())

    if @selected.length > 0
      @collection.configureFilter @options.filterName + '_filter', @selected
    else
      @collection.removeFilter @options.filterName + '_filter'
    
    @collection.goTo(1)

  initialize: ->
    @selected = []
    _.bindAll @, 'searchCollection', 'render'
    @collection.on 'reset', @render, @
    @collection.on "removed-filter:#{@options.filterName}_filter", @removedFilter, @
    super
    @

  context: ->
    collection: @collection
    selected: @selected
    filterName: @options.filterName
    fixedFilters: @options.fixedFilters
    translateTerms: @options.translateTerms
    translationPrefix: @options.translationPrefix

  render: ->
    super

  removedFilter: ->
    @selected = []

@IuguUI.SearchFilter = IuguUI.SearchFilter

