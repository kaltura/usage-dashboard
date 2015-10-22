(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.directives.side-menu', ['classy']);
  module.directive('sideMenu', function() {
    return {
      replace: true,
      restrict: 'A',
      templateUrl: 'app/scripts/common/directives/side-menu/side-menu.html',
      controller: 'SideMenuCtrl'
    };
  });
  return module.classy.controller({
    name: 'SideMenuCtrl',
    injectToScope: ['go'],
    init: function() {
      this.go.state();
      return this.$.menuItems = this.go.state('usage-dashboard').substates;
    }
  });
})();
