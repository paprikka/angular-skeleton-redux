angular.module('app.hackerNews.HackerNews', [])
.factory('HackerNews', [

  '$http'
  '$q'

  ( $http, $q ) ->
    class HackerNews
      BASE_URL = 'http://api.ihackernews.com/page?format=jsonp&callback=JSON_CALLBACK '
      query: ->
        deferred = $q.defer()

        onSuccess = ( data, status )->
          deferred.resolve data.items

        onError = ( data, status )->
          deferred.reject data

        $http.jsonp(BASE_URL)
          .success(onSuccess)
          .error(onError)

        deferred.promise
    new HackerNews
  
])