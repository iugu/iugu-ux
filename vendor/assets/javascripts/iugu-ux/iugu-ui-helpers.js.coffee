class IuguUI.Helpers
  @formatISO8601Date: ( date ) ->
    return "" unless date
    dt = date.split('-')
    return "" if dt.length < 3
    "#{dt[2]}/#{dt[1]}/#{dt[0]}"

  @bindNavigatorToCollection: ( collection, navigator, context ) ->
    navigator.context = () ->
      info = collection.info()
      currentPage: info.currentPage
      firstPage: info.firstPage
      lastPage: info.lastPage

    gotoNextPage = () ->
      collection.gotoNext()

    gotoPreviousPage = () ->
      collection.gotoPrevious()

    gotoPage = () ->
      collection.gotoPage navigator.currentPage().val()

    navigator.collection = collection

    context.on navigator.identifier() + 'next', gotoNextPage, context
    context.on navigator.identifier() + 'previous', gotoPreviousPage, context
    context.on navigator.identifier() + 'change-page', gotoPage, context

    collection.on 'all', navigator.render, navigator
    collection.on 'changed-page:success', navigator.setFocus, navigator

  @bindPaginatorToCollection: ( collection, paginator, context ) ->
    paginator.context = () ->
      currentPage: collection.info().currentPage
      firstPage: collection.info().firstPage
      lastPage: collection.info().lastPage
      pageButtons: @pageButtonsToShow(paginator.options.numberOfPageButtons, collection.info().firstPage, collection.info().lastPage, collection.info().currentPage)
      enableAdditionalButtons: paginator.options.enableAdditionalButtons

    gotoNextPage = () ->
      collection.gotoNext()

    gotoPreviousPage = () ->
      collection.gotoPrevious()

    gotoPage = () ->
      collection.gotoPage paginator.currentPage

    paginator.collection = collection

    context.on paginator.identifier() + 'next', gotoNextPage, context
    context.on paginator.identifier() + 'previous', gotoPreviousPage, context
    context.on paginator.identifier() + 'change-page', gotoPage, context

    collection.on 'all', paginator.render, paginator

@IuguUI.Helpers = IuguUI.Helpers
