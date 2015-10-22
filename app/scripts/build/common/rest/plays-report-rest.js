(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.rest.plays-report', []);
  module.service('playsReport.playsNumber', [
    'RestFactory', function(RestFactory) {
      _.extend(this, new RestFactory({
        params: {
          action: 'getTotal',
          reportType: 1
        }
      }));
      this.addFetchInterceptor((function(_this) {
        return function(response) {
          return parseInt(_this.extract.dict(response).count_plays || 0);
        };
      })(this));
      return this;
    }
  ]);
  module.service('playsReport.mediaEntriesNumber', [
    'RestFactory', function(RestFactory) {
      _.extend(this, new RestFactory({
        params: {
          action: 'getTable',
          reportType: 1,
          'pager:objectType': 'KalturaFilterPager',
          'pager:pageIndex': 1,
          'pager:pageSize': 1
        }
      }));
      this.addFetchInterceptor((function(_this) {
        return function(response) {
          return parseInt(response.totalCount || 0);
        };
      })(this));
      return this;
    }
  ]);
  module.service('playsReport.data', [
    'RestFactory', function(RestFactory) {
      return _.extend(this, new RestFactory({
        params: {
          action: 'getGraphs',
          reportType: 1,
          'reportInputFilter:interval': 'days'
        }
      }));
    }
  ]);
  return module.service('playsReport', [
    'playsReport.playsNumber', 'playsReport.mediaEntriesNumber', 'playsReport.data', function(playsNumber, mediaEntriesNumber, data) {
      return {
        playsNumber: playsNumber,
        mediaEntriesNumber: mediaEntriesNumber,
        data: data
      };
    }
  ]);
})();
