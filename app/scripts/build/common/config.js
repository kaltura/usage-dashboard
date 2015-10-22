(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.config', []);
  return module.config([
    '$urlRouterProvider', '$locationProvider', '$httpProvider', 'RestangularProvider', 'kmcProvider', function($urlRouterProvider, $locationProvider, $httpProvider, RestangularProvider, kmcProvider) {
      var kmc;
      $locationProvider.html5Mode(true);
      $locationProvider.hashPrefix('!');
      kmc = kmcProvider.$get();
      RestangularProvider.setBaseUrl(kmc.vars.service_url + "/api_v3/index.php");
      RestangularProvider.setDefaultRequestParams({
        ks: kmc.vars.ks,
        service: 'report',
        'reportInputFilter:timeZoneOffset': (new Date).getTimezoneOffset(),
        'reportInputFilter:objectType': 'KalturaReportInputFilter'
      });
      $urlRouterProvider.when('/usage-dashboard', '/usage-dashboard/overall-usage');
      return $urlRouterProvider.otherwise('/usage-dashboard');
    }
  ]);
})();
