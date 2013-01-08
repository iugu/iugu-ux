class IuguUI.Navigator extends IuguUI.Base

  layout: "iugu-ui-navigator"

  events:
    'click a.next': ->
      @handleEvent 'next'
      false
    'click a.previous': ->
      @handleEvent 'previous'
      false
    'change input.page': 'changePage'

  currentPage: ->
    @$('input.page')

  changePage: ->
    old_page = @context().currentPage
    page = @currentPage().val()
    page = old_page if page == ''
    if @context().lastPage+1 > page
      @handleEvent 'change-page'
      @lastChanged = true
      true
    else
      @currentPage().val( old_page )
      @currentPage().select()
      false

  initialize: ->
    _.bindAll @, 'changePage'
    super

  context: ->
    currentPage: 1
    firstPage: 1
    lastPage: 3

  setFocus: ->
    context = @
    if @lastChanged
      setTimeout () ->
        context.$('input.page').focus()
        context.lastChanged = false
      , 10

@IuguUI.Navigator = IuguUI.Navigator
