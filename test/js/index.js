'use strict';
var App;

App = angular.module('app', ['templates', 'ngCookies', 'ngResource', 'app.controllers', 'app.hackerNews']);

App.config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/404', {
      templateUrl: 'pages/404.html'
    }).when('/', {
      templateUrl: 'hacker-news/partials/index.html',
      controller: 'app.hackerNews.IndexCtrl'
    }).otherwise({
      redirectTo: '/404'
    });
    return $locationProvider.html5Mode(false);
  }
]).run();
