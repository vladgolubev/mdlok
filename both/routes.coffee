Router.map ->
  @configure
    layoutTemplate: 'Layout'
    loadingTemplate: 'Loading'
    waitOn: ->
      [Meteor.subscribe('students'), Meteor.subscribe('overhearedFeed')]

  @route '/',
    name: 'Home'

  @route '/auth',
    name: 'Auth'

  @route '/subjects',
    name: 'Subjects'

  @route '/rating',
    name: 'Rating'

  @route '/subject/:name@:type',
    name: 'Subject'
    data: ->
      name: @params.name
      type: @params.type

  @route '/modules',
    name: 'Modules'
    data: ->
      selectedModule: parseInt @params.hash

  @route '/logout',
    action: ->
      Meteor.logout()
      Router.go '/auth'

if not Meteor.isServer
  Router.onBeforeAction ->
    if not (Meteor.user() or Meteor.loggingIn())
      Router.go '/auth'
    @next()
  , except: ['auth']