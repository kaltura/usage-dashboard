(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.kmc-config', []);
  return module.provider('kmc', function() {
    return {
      $get: function() {
        return window.kmc || {
          vars: {
            service_url: 'http://www.kaltura.com',
            ks: 'Y2M0MDY1ZWU5ZTk2NThhMjJlMzgyMzM2MzUwYzVjMTUyNmZjZmY3MHw5MzkzNDE7OTM5MzQxOzE0NDU2MDUyOTM7MjsxNDQ1NTE4ODkzLjMxMzg7cmtzaGFyZWRib3hAZ21haWwuY29tO2Rpc2FibGVlbnRpdGxlbWVudDs7'
          }
        };
      }
    };
  });
})();
