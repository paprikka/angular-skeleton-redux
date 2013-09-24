angular.module('app.hackerNews.IndexCtrl', ['app.hackerNews']).controller('app.hackerNews.IndexCtrl', [

  '$scope'
  'HackerNews'

  ( $scope, HackerNews )->

    HackerNews
      .query()
      .then ( res )->
        $scope.news = res
      

])