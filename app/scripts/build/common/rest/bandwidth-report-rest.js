(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.rest.bandwidth-report', []);
  return module.service('bandwidthReport', [
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
