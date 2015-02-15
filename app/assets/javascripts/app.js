'use strict';

var godo = angular.module('godo', [
  'templates',
  'ngRoute',
  'ngResource',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
]);

godo.config(['$routeProvider', function ($routeProvider) {
  $routeProvider.when('/', {
    templateUrl: 'index.html',
    controller: 'EventsController'
  })
  .otherwise({
    redirectTo: '/'
  });
}]);

godo.controller("EventsController", [
  '$scope', '$routeParams', '$location', '$resource',
  function ($scope, $routeParams, $location, $resource) {

    var Event = $resource('/events/:eventId', { eventId: "@id", format: 'json' });

    $scope.search = function(keywords) {
      return $location.path("/").search('keywords',keywords);
    };

    if ($routeParams.keywords) {
      Event.query({keywords: $routeParams.keywords}, function (results) {
        $scope.events = results;
        console.log($scope.events);
      });
    }
    else $scope.events = []
  }
]);
