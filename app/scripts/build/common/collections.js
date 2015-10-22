(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.collections', []);
  return module.service('reportControlsSelectCollection', [
    'Collection', function(Collection) {
      _.extend(this, new Collection);
      this.add([
        {
          id: 0,
          name: 'Last month',
          dates: {
            low: function() {
              return new Date((new Date).subMonth().setDate(1));
            },
            high: function() {
              return new Date((new Date).setDate(0));
            }
          }
        }, {
          id: 1,
          name: 'Last 3 months',
          "default": true,
          dates: {
            low: function() {
              return new Date((new Date).subMonth(3).setDate(1));
            },
            high: function() {
              return new Date((new Date).setDate(0));
            }
          }
        }, {
          id: 2,
          name: 'Custom date range by month',
          allowDatepickers: true
        }
      ]);
      return this;
    }
  ]);
})();
