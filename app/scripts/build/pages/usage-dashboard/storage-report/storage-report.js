(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.storage-report', ['classy']);
  module.config([
    '$stateProvider', function($stateProvider) {
      return $stateProvider.state('usage-dashboard.storage', {
        url: '/storage',
        views: {
          main: {
            controller: 'StorageReportCtrl',
            templateUrl: 'app/scripts/pages/usage-dashboard/storage-report/storage-report.html'
          }
        },
        data: {
          pageTitle: 'Storage Report'
        }
      });
    }
  ]);
  return module.classy.controller({
    name: 'StorageReportCtrl'
  });
})();
