(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.overall-usage-report', ['classy']);
  module.config([
    '$stateProvider', function($stateProvider) {
      return $stateProvider.state('usage-dashboard.overall-usage', {
        url: '/overall-usage',
        views: {
          main: {
            controller: 'OverallUsageReportCtrl',
            templateUrl: 'app/scripts/pages/usage-dashboard/overall-usage-report/overall-usage-report.html'
          }
        },
        data: {
          pageTitle: 'Overall Usage Report'
        }
      });
    }
  ]);
  return module.classy.controller({
    name: 'OverallUsageReportCtrl'
  });
})();
