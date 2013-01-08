class IuguUI.Paginator extends IuguUI.Base

  layout: "iugu-ui-paginator"

  defaults:
    numberOfPageButtons: 9
    enableAdditionalButtons: true

  events:
    'click a.page': 'gotoPage'
    'click a.next': ->
      @handleEvent 'next'
      false
    'click a.previous': ->
      @handleEvent 'previous'
      false

  initialize: ->
    super

  context: ->
    currentPage: 1
    firstPage: 1
    lastPage: 1
    enableAdditionalButtons: @options.enableAdditionalButtons
    pageButtons: @pageButtonsToShow(10, 1, 10, 1)

  currentPage: 1

  gotoPage: (e) ->
    e.preventDefault()
    return if $(e.target).text() == '...'
    @currentPage = $(e.target).text()
    @handleEvent 'change-page'

  pageButtonsToShow: (numberOfButtons, firstPage, totalPages, currentPage) ->
    return unless totalPages

    if numberOfButtons > totalPages
      return _.range(2, totalPages)

    surrounding = (numberOfButtons - 3) / 2

    begin = currentPage - Math.floor(surrounding)
    end = currentPage + Math.ceil(surrounding)

    if begin <= firstPage + 1
      offset = firstPage + 1 - begin
      begin += offset
      end += offset
    else if end >= totalPages - 1
      offset = totalPages - end - 1
      begin += offset
      end += offset

    _.range(begin, end + 1)

@IuguUI.Paginator = IuguUI.Paginator
