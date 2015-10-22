(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.plays-report', ['classy']);
  module.config([
    '$stateProvider', function($stateProvider) {
      return $stateProvider.state('usage-dashboard.plays', {
        url: '/plays',
        views: {
          main: {
            controller: 'PlaysReportCtrl',
            templateUrl: 'app/scripts/pages/usage-dashboard/plays-report/plays-report.html'
          }
        },
        data: {
          pageTitle: 'Plays Report'
        }
      });
    }
  ]);
  return module.classy.controller({
    name: 'PlaysReportCtrl',
    inject: ['playsReport'],
    fetch: function() {
      this._extractPayload();
      this._fetchPlaysNumber();
      this._fetchMediaEntriesNumber();
      return this._fetchData();
    },
    _extractPayload: function() {
      return this.payload = {
        'reportInputFilter:fromDay': this.$.dates.from.toYMDn(),
        'reportInputFilter:toDay': this.$.dates.to.toYMDn()
      };
    },
    _fetchPlaysNumber: function() {
      return this.playsReport.playsNumber.fetch(this.payload).then((function(_this) {
        return function(response) {
          return _this.$.playsNumber = response;
        };
      })(this));
    },
    _fetchMediaEntriesNumber: function() {
      return this.playsReport.mediaEntriesNumber.fetch(this.payload).then((function(_this) {
        return function(response) {
          return _this.$.mediaEntriesNumber = response;
        };
      })(this));
    },
    _fetchData: function() {
      return this.playsReport.data.fetch(this.payload).then((function(_this) {
        return function(response) {
          return console.log(response);
        };
      })(this));
    }
  });
})();
