(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.directives.datepicker', ['classy']);
  module.directive('kalturaDatepicker', function() {
    return {
      restrict: 'A',
      replace: true,
      templateUrl: 'app/scripts/common/directives/datepicker/datepicker.html',
      controller: 'KalturaDatepickerCtrl',
      scope: {
        model: '=datepicker',
        name: '=?'
      }
    };
  });
  return module.classy.controller({
    name: 'KalturaDatepickerCtrl',
    inject: ['$element'],
    init: function() {
      this.$.options = {
        changeYear: true,
        changeMonth: true,
        yearRange: '2000:-0'
      };
      if (!this.$.name) {
        this.$.name = 'datepicker';
      }
      if (!this.$.model) {
        return this.$.model = new Date;
      }
    },
    open: function() {
      this.$element.find('input').datepicker('show');
      return null;
    },
    hide: function() {
      this.$element.find('input').datepicker('hide');
      return null;
    }
  });
})();

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
    name: 'HeaderCtrl'
  });
})();

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
    name: 'SideMenuCtrl'
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.bandwidth-report', ['classy']);
  module.config(function($stateProvider) {
    return $stateProvider.state('usage-dashboard.bandwidth', {
      url: '/bandwidth',
      views: {
        main: {
          controller: 'BandwidthReportCtrl',
          templateUrl: 'app/scripts/pages/usage-dashboard/bandwidth-report/bandwidth-report.html'
        }
      },
      data: {
        pageTitle: 'Bandwidth Report'
      }
    });
  });
  return module.classy.controller({
    name: 'BandwidthReportCtrl'
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.media-entries-report', ['classy']);
  module.config(function($stateProvider) {
    return $stateProvider.state('usage-dashboard.media-entries', {
      url: '/media-entries',
      views: {
        main: {
          controller: 'MediaEntriesReportCtrl',
          templateUrl: 'app/scripts/pages/usage-dashboard/media-entries/media-entries-report.html'
        }
      },
      data: {
        pageTitle: 'Media Entries Report'
      }
    });
  });
  return module.classy.controller({
    name: 'MediaEntriesReportCtrl'
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.overall-usage-report', ['classy']);
  module.config(function($stateProvider) {
    return $stateProvider.state('usage-dashboard.overall-usage', {
      url: '/overall-usage',
      views: {
        main: {
          controller: 'OverallUsageReportCtrl',
          templateUrl: 'app/scripts/pages/usage-dashboard/overall-usage-report/overall-usage-report.html'
        }
      },
      data: {
        pageTitle: 'Overall Usage Report'
      }
    });
  });
  return module.classy.controller({
    name: 'OverallUsageReportCtrl'
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.plays-report', ['classy']);
  module.config(function($stateProvider) {
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
  });
  return module.classy.controller({
    name: 'PlaysReportCtrl'
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.storage-report', ['classy']);
  module.config(function($stateProvider) {
    return $stateProvider.state('usage-dashboard.storage', {
      url: '/storage',
      views: {
        main: {
          controller: 'StorageReportCtrl',
          templateUrl: 'app/scripts/pages/usage-dashboard/storage-report/storage-report.html'
        }
      },
      data: {
        pageTitle: 'Storage Report'
      }
    });
  });
  return module.classy.controller({
    name: 'StorageReportCtrl'
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard.transcoding-consumption-report', ['classy']);
  module.config(function($stateProvider) {
    return $stateProvider.state('usage-dashboard.transcoding-consumption', {
      url: '/transcoding-consumption',
      views: {
        main: {
          controller: 'TranscodingConsumptionReportCtrl',
          templateUrl: 'app/scripts/pages/usage-dashboard/transcoding-consumption-report/transcoding-consumption-report.html'
        }
      },
      data: {
        pageTitle: 'Transcoding Consumption Report'
      }
    });
  });
  return module.classy.controller({
    name: 'TranscodingConsumptionReportCtrl'
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.usage-dashboard', ['classy', 'KalturaUsageDashboard.usage-dashboard.overall-usage-report', 'KalturaUsageDashboard.usage-dashboard.plays-report', 'KalturaUsageDashboard.usage-dashboard.storage-report', 'KalturaUsageDashboard.usage-dashboard.bandwidth-report', 'KalturaUsageDashboard.usage-dashboard.transcoding-consumption-report', 'KalturaUsageDashboard.usage-dashboard.media-entries-report']);
  module.config(function($stateProvider, $urlRouterProvider) {
    return $stateProvider.state('usage-dashboard', {
      url: '/usage-dashboard',
      views: {
        main: {
          controller: 'UsageDashboardCtrl',
          templateUrl: 'app/scripts/pages/usage-dashboard/usage-dashboard.html'
        }
      },
      data: {
        pageTitle: 'Usage Dashboard'
      }
    });
  });
  return module.classy.controller({
    name: 'UsageDashboardCtrl'
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.config', []);
  return module.config(function($urlRouterProvider, $locationProvider, $httpProvider, RestangularProvider) {
    $locationProvider.html5Mode(true);
    $locationProvider.hashPrefix('!');
    RestangularProvider.setBaseUrl('api/');
    $urlRouterProvider.when('/usage-dashboard', '/usage-dashboard/overall-usage');
    return $urlRouterProvider.otherwise('/usage-dashboard');
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard', ['angular-flot', 'rt.select2', 'ui.date', 'ui.bootstrap', 'ui.router', 'restangular', 'classy', 'KalturaUsageDashboard.config', 'KalturaUsageDashboard.directives.header', 'KalturaUsageDashboard.directives.side-menu', 'KalturaUsageDashboard.directives.datepicker', 'KalturaUsageDashboard.usage-dashboard']);
  return module.classy.controller({
    name: 'KalturaUsageDashboardCtrl'
  });
})();
