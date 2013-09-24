angular
.module('app.ui.logo', [])
.directive 'appLogo', ->
  restrict: 'AE'
  templateUrl: 'ui/logo/logo.html'
  link: (scope, elm, attr)->
