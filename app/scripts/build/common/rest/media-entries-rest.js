(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.rest.media-entries-report', []);
  return module.service('mediaEntriesReport', [
    'RestFactory', function(RestFactory) {
      return new RestFactory({
        params: {
          action: 'getGraphs',
          reportType: 5,
          'reportInputFilter:interval': 'days'
        }
      });
    }
  ]);
})();
