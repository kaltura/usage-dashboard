(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.directives.header', ['classy']);
  module.directive('header', function() {
    return {
      replace: true,
      restrict: 'A',
      templateUrl: 'app/scripts/common/directives/header/header.html',
      controller: 'HeaderCtrl'
    };
  });
  return module.classy.controller({
    name: 'HeaderCtrl',
    injectToScope: ['go'],
    init: function() {
      return this.$.items = this.go.state().substates;
    }
  });
})();
