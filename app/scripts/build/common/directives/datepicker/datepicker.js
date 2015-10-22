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
        model: '=kalturaDatepicker',
        disabled: '=',
        min: '=?',
        max: '=?',
        name: '=?'
      }
    };
  });
  return module.classy.controller({
    name: 'KalturaDatepickerCtrl',
    inject: ['$element', '$timeout'],
    init: function() {
      this.input = this.$element.find('input');
      this.$.options = {
        changeYear: true,
        changeMonth: true,
        yearRange: '2000:-0'
      };
      if (!this.$.name) {
        this.$.name = 'datepicker';
      }
      return this.$timeout((function(_this) {
        return function() {
          _this._flushMin();
          return _this._flushMax();
        };
      })(this));
    },
    watch: {
      min: function(value) {
        if (value) {
          return this._flushMin();
        }
      },
      max: function(value) {
        if (value) {
          return this._flushMax();
        }
      }
    },
    _flushMin: function() {
      return this.input.datepicker('option', 'minDate', this.$.min);
    },
    _flushMax: function() {
      return this.input.datepicker('option', 'maxDate', this.$.max);
    },
    open: function() {
      this.input.datepicker('show');
      return null;
    },
    hide: function() {
      this.input.datepicker('hide');
      return null;
    }
  });
})();
