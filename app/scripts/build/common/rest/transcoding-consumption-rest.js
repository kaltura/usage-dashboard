(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.rest.transcoding-consumption-report', []);
  return module.service('transcodingConsumptionReport', [
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
