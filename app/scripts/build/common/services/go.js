(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.services.go', []);
  return module.service('go', [
    '$state', function($state) {
      return _.extend(this, {
        current: function() {
          return $state.current;
        },
        go: function() {
          return $state.go.apply($state, arguments);
        },
        $state: $state,
        state: (function(_this) {
          return function(name) {
            var state;
            return _.extend($state.get(name) || {}, {
              substates: ((function() {
                var i, len, ref, results;
                ref = $state.get();
                results = [];
                for (i = 0, len = ref.length; i < len; i++) {
                  state = ref[i];
                  if (state.name.includes(name || '') && state.name.length && state.name.nPoints() === (name != null ? name.nPoints() + 1 : 0)) {
                    results.push(this.state(state.name));
                  }
                }
                return results;
              }).call(_this)) || []
            });
          };
        })(this),
        flags: {
          loading: 0
        },
        inc: (function(_this) {
          return function(n) {
            if (n == null) {
              n = 1;
            }
            return _this.flags.loading += n;
          };
        })(this),
        dec: (function(_this) {
          return function(n) {
            if (n == null) {
              n = 1;
            }
            return _this.flags.loading -= n;
          };
        })(this),
        isLoading: (function(_this) {
          return function() {
            var key, ref, value;
            ref = _this.flags;
            for (key in ref) {
              value = ref[key];
              if (value > 0) {
                return true;
              }
            }
            return false;
          };
        })(this)
      });
    }
  ]);
})();
