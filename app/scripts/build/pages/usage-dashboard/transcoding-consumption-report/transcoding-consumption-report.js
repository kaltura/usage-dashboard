(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.transcoding-consumption-report', ['classy']);
  module.config([
    '$stateProvider', function($stateProvider) {
      return $stateProvider.state('usage-dashboard.transcoding-consumption', {
        url: '/transcoding-consumption',
        views: {
          main: {
            controller: 'TranscodingConsumptionReportCtrl',
            templateUrl: 'app/scripts/pages/usage-dashboard/transcoding-consumption-report/transcoding-consumption-report.html'
          }
        },
        data: {
          pageTitle: 'Transcoding Consumption Report'
        }
      });
    }
  ]);
  return module.classy.controller({
    name: 'TranscodingConsumptionReportCtrl'
  });
})();
