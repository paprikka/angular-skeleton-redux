'use strict'
# Declare app level module which depends on filters, and services
App = angular.module('app', [

  # ## Vendor modules / components
  'templates'
  'ngCookies'
  'ngResource'


  # ## Application components
  'app.controllers'

])

App.config([
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->

    $routeProvider

      # Pages
      # ---------------------------------------------------

      # .when('/users/login', {
      #   templateUrl: 'partials/views/users/login.html'
      #   controller: 'app.controllers.UsersLoginCtrl'})

      # .when('/users/logout', {
      #   templateUrl: 'partials/views/users/login.html'
      #   controller: 'app.controllers.UsersLoginCtrl'})

      # .when('/users', {
      #   templateUrl: 'partials/views/users/index.html'
      #   controller: 'app.controllers.UsersIndexCtrl'
      #   access: ['administrator']
      #   })

      # .when('/users/index', {
      #   redirectTo: '/users'
      #   access: ['administrator']
      # })

      # .when('/users/add', {
      #   templateUrl: 'partials/views/users/add.html'
      #   controller: 'app.controllers.UsersAddCtrl'
      #   access: ['administrator']
      #   })

      # .when('/users/set-password/:id', {
      #   templateUrl: 'partials/views/users/set-password.html'
      #   controller: 'app.controllers.UsersSetPasswordCtrl'})

      # .when('/users/edit/:id', {
      #   templateUrl: 'partials/views/users/edit.html'
      #   controller: 'app.controllers.UsersEditCtrl'
      #   access: ['administrator']
      #   })

  


      # .when('/404', {templateUrl: 'partials/views/pages/404.html'})

      .when('/', templateUrl: 'pages/partials/intro.html')

      # Catch all / 404
      .otherwise({redirectTo: '/404'})

    # Without server side support html5 must be disabled.
    $locationProvider.html5Mode off

]).run()


