(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.bandwidth-report', ['classy']);
  module.config([
    '$stateProvider', function($stateProvider) {
      return $stateProvider.state('usage-dashboard.bandwidth', {
        url: '/bandwidth',
        views: {
          main: {
            controller: 'BandwidthReportCtrl',
            templateUrl: 'app/scripts/pages/usage-dashboard/bandwidth-report/bandwidth-report.html'
          }
        },
        data: {
          pageTitle: 'Bandwidth Report'
        }
      });
    }
  ]);
  return module.classy.controller({
    name: 'BandwidthReportCtrl'
  });
})();
