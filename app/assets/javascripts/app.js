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

var events = [
  {
    id: 1,
    name: "Skydiving with friends",
    description: "Jump from 20,000 feet!"
  },
  {
    id: 2,
    name: "White-water river rafting",
    description: "Don't hit a rock."
  },
  {
    id: 3,
    name: "Trip to Saturn",
    description: "Total interstellar move."
  },
  {
    id: 4,
    name: "Skydiving with associates",
    description: "Push them out of the plane"
  }
]

godo.controller("EventsController", [
  '$scope', '$routeParams', '$location', '$resource',
  function ($scope, $routeParams, $location, $resource) {

    // var Event = $resource('/events/:eventId', { eventId: "@id", format: 'json' });

    $scope.search = function(keywords) {
      return $location.path("/").search('keywords',keywords);
    };

    if ($routeParams.keywords) {
      var keywords = $routeParams.keywords.toLowerCase();
      $scope.events = events.filter(function(event) {
        return event.name.toLowerCase().indexOf(keywords) != -1;
      })
      // Event.query({keywords: $routeParams.keywords}, function (results) {
      //   $scope.events = results;
      //   console.log($scope.events);
      // });
    }
    else $scope.events = []
  }
]);
