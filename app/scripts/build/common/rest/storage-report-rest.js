(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.rest.storage-report', []);
  return module.service('storageReport', [
    'RestFactory', function(RestFactory) {
      return new RestFactory({
        params: {
          action: 'getGraphs',
          reportType: 201,
          'reportInputFilter:interval': 'months'
        }
      });
    }
  ]);
})();
