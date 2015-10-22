(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.directives.report-controls', ['classy']);
  module.directive('reportControls', function() {
    return {
      replace: true,
      restrict: 'A',
      templateUrl: 'app/scripts/common/directives/report-controls/report-controls.html',
      controller: 'ReportControlsCtrl',
      scope: {
        from: '=?',
        to: '=?',
        changed: '&',
        disabled: '='
      }
    };
  });
  return module.classy.controller({
    name: 'ReportControlsCtrl',
    inject: ['$timeout'],
    injectToScope: ['reportControlsSelectCollection', 'go'],
    init: function() {
      return this._initParams();
    },
    watch: {
      'select.model': function(value, old) {
        if (value === old || (value == null)) {
          return;
        }
        this._calcRange();
        return this._changed();
      },
      'dates.low': function(value, old) {
        if (value === old || (value == null)) {
          return;
        }
        this._calcFrom();
        return this._changed();
      },
      'dates.high': function(value, old) {
        if (value === old || (value == null)) {
          return;
        }
        this._calcTo();
        return this._changed();
      }
    },
    _initParams: function() {
      this.$.select = {
        data: this.reportControlsSelectCollection.arr,
        options: {
          allowClear: false,
          placeholder: 'Select period...',
          minimumResultsForSearch: -1
        },
        model: this.reportControlsSelectCollection.singleWhere({
          "default": true
        }).id
      };
      this.$.dates = {
        low: new Date,
        high: new Date
      };
      this._calcRange();
      return this._changed();
    },
    _changed: function() {
      return this.$timeout((function(_this) {
        return function() {
          var base;
          return typeof (base = _this.$).changed === "function" ? base.changed() : void 0;
        };
      })(this));
    },
    _calcRange: function() {
      this.$.range = this.reportControlsSelectCollection.by(this.$.select.model);
      this._calcFrom();
      return this._calcTo();
    },
    _calcFrom: function() {
      return this.$.from = this.$.range.allowDatepickers ? this.$.dates.low : this.$.range.dates.low();
    },
    _calcTo: function() {
      return this.$.to = this.$.range.allowDatepickers ? this.$.dates.high : this.$.range.dates.high();
    }
  });
})();
