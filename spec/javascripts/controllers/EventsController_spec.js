describe('Controller: EventsController', function () {

  var EventsController = null;
  var scope            = null;
  var location         = null;
  var routeParams      = null;
  var resource         = null;
  var keywords         = null;

  // access injected service later
  var httpBackend  = null;

  setupController = function(keywords, results) {
    inject(function () {
      scope                = $rootScope.$new();
      location             = $location;
      resource             = $resource;
      routeParams          = $routeParams;
      routeParams.keywords = keywords;

      // capture the injected service
      httpBackend = $httpBackend;

      // if (results) {
      //   var request = new RegExp("\/events.*keywords=#{keywords}");
      //   httpBackend.expectGET(request).respond(results);
      // }

      EventsController = $controller('EventsController', {
        $scope: scope,
        $location: location
      });
    })
  };

  beforeEach(module("godo"));
  beforeEach(setupController());

  it('defaults to no events', function () {
    expect(scope.events.length).toBe(0);
  });

});
