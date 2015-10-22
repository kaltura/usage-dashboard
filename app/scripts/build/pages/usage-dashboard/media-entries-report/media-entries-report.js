(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.media-entries-report', ['classy']);
  module.config([
    '$stateProvider', function($stateProvider) {
      return $stateProvider.state('usage-dashboard.media-entries', {
        url: '/media-entries',
        views: {
          main: {
            controller: 'MediaEntriesReportCtrl',
            templateUrl: 'app/scripts/pages/usage-dashboard/media-entries-report/media-entries-report.html'
          }
        },
        data: {
          pageTitle: 'Media Entries Report'
        }
      });
    }
  ]);
  return module.classy.controller({
    name: 'MediaEntriesReportCtrl'
  });
})();
