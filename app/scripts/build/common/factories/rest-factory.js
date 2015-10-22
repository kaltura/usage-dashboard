(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.factories.rest', []);
  return module.factory('RestFactory', [
    'Restangular', 'Collection', 'x2js', 'go', function(Restangular, Collection, x2js, go) {
      return function(config) {
        _.extend(config, {
          dontCollect: true
        });
        _.extend(this, new Collection(Restangular.one(''), config), {
          extract: {
            dict: function(response) {
              var keys, values;
              keys = response.header.split(',');
              values = response.data.split(',');
              return _.zipObject(keys, values);
            }
          }
        });
        this.addFetchInterceptor(function(response) {
          return x2js.xml_str2json(response).xml.result;
        });
        this.extendFetch({
          b: function() {
            return go.inc();
          },
          f: function() {
            return go.dec();
          }
        });
        return this;
      };
    }
  ]);
})();
