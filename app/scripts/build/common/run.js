(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.run', []);
  module.run([
    'ArrayPrototype', 'StringPrototype', 'DatePrototype', function(ArrayPrototype, StringPrototype, DatePrototype) {
      _.extend(Array.prototype, ArrayPrototype);
      _.extend(String.prototype, StringPrototype);
      return _.extend(Date.prototype, DatePrototype);
    }
  ]);
  return module.run([
    '$window', 'utils', function($window, utils) {
      $window.isMobileOrTablet = utils.navigator.isMobileOrTablet();
      return $window.isMobile = utils.navigator.isMobile();
    }
  ]);
})();
