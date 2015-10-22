(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.collections', []);
  return module.service('reportControlsSelectCollection', function(Collection) {
    _.extend(this, new Collection);
    this.add([
      {
        id: 0,
        name: 'Last month'
      }, {
        id: 1,
        name: 'Last 3 months',
        "default": true
      }, {
        id: 2,
        name: 'Custom date range by month',
        allowDatepickers: true
      }
    ]);
    return this;
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.config', []);
  return module.config(function($urlRouterProvider, $locationProvider, $httpProvider, RestangularProvider, kmcProvider) {
    var kmc;
    $locationProvider.html5Mode(true);
    $locationProvider.hashPrefix('!');
    kmc = kmcProvider.$get();
    RestangularProvider.setBaseUrl(kmc.vars.service_url + "/api_v3/index.php");
    RestangularProvider.setDefaultRequestParams({
      ks: kmc.vars.ks,
      service: 'report',
      'reportInputFilter:timeZoneOffset': (new Date).getTimezoneOffset(),
      'reportInputFilter:objectType': 'KalturaReportInputFilter'
    });
    $urlRouterProvider.when('/usage-dashboard', '/usage-dashboard/overall-usage');
    return $urlRouterProvider.otherwise('/usage-dashboard');
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.constants', []);
  module.constant('dayms', 1000 * 60 * 60 * 24);
  module.constant('graph', {
    colorColumn: '#02a3d1',
    colorAxis: '#c2d2e1',
    mainBg: '#f0eeef',
    borderWidth: 7
  });
  module.constant('ArrayPrototype', {
    byField: function(field, value) {
      var e, index, j, len;
      for (index = j = 0, len = this.length; j < len; index = ++j) {
        e = this[index];
        if (e[field] === value) {
          return this[index];
        }
      }
    },
    each: function(fn) {
      var e, index, j, len, results;
      results = [];
      for (index = j = 0, len = this.length; j < len; index = ++j) {
        e = this[index];
        results.push(fn(e, index, this));
      }
      return results;
    },
    contains: function(k) {
      var e, index, j, len;
      if (k) {
        for (index = j = 0, len = this.length; j < len; index = ++j) {
          e = this[index];
          if ((k.id != null) && e.id === k.id || this[index] === k || e.id === k) {
            return true;
          }
        }
      }
      return false;
    },
    pushArray: function(arr) {
      var e, j, len;
      if (arr && arr.length) {
        for (j = 0, len = arr.length; j < len; j++) {
          e = arr[j];
          this.push(e);
        }
      }
      return this;
    },
    replace: function(wht, wth) {
      var e, index, j, len, results;
      results = [];
      for (index = j = 0, len = this.length; j < len; index = ++j) {
        e = this[index];
        if (e === wht) {
          results.push(this[index] = wth);
        }
      }
      return results;
    },
    remove: function(item) {
      var i, index, j, len;
      for (index = j = 0, len = this.length; j < len; index = ++j) {
        i = this[index];
        if (item === i) {
          this.splice(index, 1);
          break;
        }
      }
      return item;
    },
    clear: function() {
      while (this.length) {
        this.remove(this[0]);
      }
      return this;
    }
  });
  module.constant('StringPrototype', {
    noSpaces: function() {
      return this.replace(/\s/g, '');
    },
    splice: function(idx, rem, s) {
      return this.slice(0, idx) + s + this.slice(idx + Math.abs(rem));
    },
    nMatches: function(str) {
      var r;
      r = new RegExp(str, 'g');
      return (this.match(r) || []).length;
    },
    nPoints: function() {
      return this.nMatches('\\\.');
    }
  });
  return module.service('DatePrototype', function($filter, dayms) {
    return {
      fullzero: function() {
        this.setYear(0);
        this.setMonth(0);
        this.setDate(1);
        return this.zero();
      },
      zero: function() {
        this.setHours(0, 0, 0, 0);
        return this;
      },
      dateTimeZoneFix: function() {
        return new Date(this.setHours(this.getHours() + this.getTimezoneOffset() / 60));
      },
      toMonthStart: function() {
        this.setDate(1);
        return this;
      },
      toMonthEnd: function() {
        this.setMonth(this.getMonth() + 1);
        this.setDate(0);
        return this;
      },
      toYMD: function() {
        return $filter('date')(this, 'yyyy-MM-dd');
      },
      toMDY: function() {
        return $filter('date')(this);
      },
      dg: function(date) {
        var v1, v2;
        v1 = this.valueOf() / dayms;
        v2 = (new Date(date)).valueOf() / dayms;
        return v1 > v2;
      },
      ds: function(date) {
        return (new Date(date)).dg(this);
      },
      dge: function(date) {
        var v1, v2;
        v1 = this.valueOf() / dayms;
        v2 = (new Date(date)).valueOf() / dayms;
        return v1 >= v2;
      },
      dse: function(date) {
        return (new Date(date)).dge(this);
      },
      de: function(date) {
        var v1, v2;
        v1 = this.valueOf() / dayms;
        v2 = (new Date(date)).valueOf() / dayms;
        return v1 === v2;
      },
      dg_ms: function(date) {
        var v1, v2;
        v1 = this.valueOf();
        v2 = (new Date(date)).valueOf();
        return v1 > v2;
      },
      ds_ms: function(date) {
        var v1, v2;
        v1 = this.valueOf();
        v2 = (new Date(date)).valueOf();
        return v1 < v2;
      },
      dge_ms: function(date) {
        var v1, v2;
        v1 = this.valueOf();
        v2 = (new Date(date)).valueOf();
        return v1 >= v2;
      },
      dse_ms: function(date) {
        var v1, v2;
        v1 = this.valueOf();
        v2 = (new Date(date)).valueOf();
        return v1 <= v2;
      },
      dgNow: function() {
        return this.dg_ms(new Date);
      },
      dsNow: function() {
        return this.ds_ms(new Date);
      },
      de_ymd: function(date) {
        var d1, d2, v1, v2;
        d1 = new Date(this);
        d2 = new Date(date);
        v1 = (d1.setHours(0, 0, 0, 0)).valueOf() / dayms;
        v2 = (d2.setHours(0, 0, 0, 0)).valueOf() / dayms;
        return v1 === v2;
      },
      tge: function(date) {
        var d1, d2, h1, h2, m1, m2;
        d2 = new Date(date);
        d1 = new Date(this);
        h1 = d1.getHours();
        h2 = d2.getHours();
        m2 = d2.getMinutes();
        m1 = d1.getMinutes();
        return h1 * 60 + m1 >= h2 * 60 + m2;
      },
      te: function(date) {
        var d1, d2, h1, h2, m1, m2;
        d1 = new Date(this);
        d2 = new Date(date);
        h1 = d1.getHours();
        h2 = d2.getHours();
        m1 = d1.getMinutes();
        m2 = d2.getMinutes();
        return h1 === h2 && m1 === m2;
      },
      tse: function(date) {
        var d1, d2, h1, h2, m1, m2, s1, s2;
        d1 = new Date(this);
        d2 = new Date(date);
        h1 = d1.getHours();
        h2 = d2.getHours();
        m1 = d1.getMinutes();
        m2 = d2.getMinutes();
        s1 = d1.getSeconds();
        s2 = d2.getSeconds();
        return h1 === h2 && m1 === m2 && s1 === s2;
      },
      isInMonth: function(date) {
        date = new Date(date);
        return date.getFullYear() === this.getFullYear() && date.getMonth() === this.getMonth();
      },
      isInPreviousMonth: function(date) {
        date = new Date(date);
        return this.isInMonth(date.setMonth(date.getMonth() - 1));
      }
    };
  });
})();

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

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.directives.graph', ['classy']);
  module.directive('graph', function() {
    return {
      replace: true,
      restrict: 'A',
      templateUrl: 'app/scripts/common/directives/graph/graph.html',
      controller: 'GraphCtrl',
      scope: {
        data: '=graph'
      }
    };
  });
  return module.classy.controller({
    name: 'GraphCtrl',
    inject: ['graph'],
    init: function() {
      var data;
      data = [[0, 12], [1, 37], [2, 1], [3, 75]];
      return this.$.graph = {
        data: [
          {
            color: this.graph.colorColumn,
            data: data
          }
        ],
        options: {
          series: {
            bars: {
              show: true,
              fill: true,
              fillColor: this.graph.colorColumn
            }
          },
          tooltip: {
            show: true,
            content: function(label, x, y, flot) {
              return "<div class='text'>" + flot.series.xaxis.ticks[flot.dataIndex].label + "</div>\n<div class='value'>" + flot.series.data[flot.dataIndex][1] + "</div>";
            },
            cssClass: 'graph-tooltip'
          },
          bars: {
            align: 'center',
            barWidth: 0.75
          },
          xaxis: {
            show: true,
            color: this.graph.colorAxis,
            axisLabel: 'Months',
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'arial,sans serif',
            axisLabelPadding: 12,
            ticks: [[0, 'August, 2015'], [1, 'September, 2015'], [2, 'October, 2015'], [3, 'November, 2015']],
            tickLength: 0,
            min: -0.5,
            max: data.length - 0.5
          },
          yaxis: {
            axisLabel: 'Plays Number',
            color: this.graph.colorAxis,
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'arial,sans serif',
            axisLabelPadding: 10,
            reserveSpace: true,
            tickLength: 15
          },
          legend: {
            noColumns: 0,
            labelBoxBorderColor: '#000000',
            position: 'nw'
          },
          grid: {
            show: true,
            hoverable: true,
            clickable: true,
            borderWidth: {
              top: 0,
              right: 0,
              bottom: this.graph.borderWidth,
              left: this.graph.borderWidth
            },
            borderColor: this.graph.colorAxis,
            backgroundColor: this.graph.mainBg,
            aboveData: false,
            axisMargin: 10
          }
        }
      };
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
    name: 'HeaderCtrl',
    injectToScope: ['go'],
    init: function() {
      return this.$.items = this.go.state().substates;
    }
  });
})();

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
        range: '=?',
        dates: '=?',
        changed: '&',
        disabled: '='
      }
    };
  });
  return module.classy.controller({
    name: 'ReportControlsCtrl',
    injectToScope: ['reportControlsSelectCollection'],
    init: function() {
      var base;
      this.$.select = {
        data: this.reportControlsSelectCollection.arr,
        options: {
          allowClear: false,
          placeholder: 'Select period...',
          minimumResultsForSearch: -1
        }
      };
      this.$.select.model = this.reportControlsSelectCollection.singleWhere({
        "default": true
      }).id;
      this.$.dates = {
        low: new Date,
        high: new Date
      };
      return typeof (base = this.$).changed === "function" ? base.changed() : void 0;
    },
    watch: {
      'select.model': function(value, old) {
        var base;
        if (value === old || (value == null)) {
          return;
        }
        this.$.range = this.reportControlsSelectCollection.by(value);
        return typeof (base = this.$).changed === "function" ? base.changed() : void 0;
      },
      'dates.low': function(value, old) {
        var base;
        if (value === old || (value == null)) {
          return;
        }
        if (value != null) {
          return typeof (base = this.$).changed === "function" ? base.changed() : void 0;
        }
      },
      'dates.high': function(value, old) {
        var base;
        if (value === old || (value == null)) {
          return;
        }
        if (value != null) {
          return typeof (base = this.$).changed === "function" ? base.changed() : void 0;
        }
      }
    }
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
    name: 'SideMenuCtrl',
    injectToScope: ['go'],
    init: function() {
      this.go.state();
      return this.$.menuItems = this.go.state('usage-dashboard').substates;
    }
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.factories.rest', []);
  return module.factory('RestFactory', function(Restangular, Collection, x2js) {
    return function(config) {
      var rest;
      _.extend(config, {
        dontCollect: true
      });
      rest = new Collection(Restangular.one(''), config);
      rest.addFetchInterceptor(function(response) {
        return x2js.xml_str2json(response).xml.result;
      });
      return rest;
    };
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.kmc-config', []);
  return module.provider('kmc', function() {
    return {
      $get: function() {
        return window.kmc || {
          vars: {
            service_url: 'http://www.kaltura.com',
            ks: 'YTQ2OGFkNDVmYzU5ZTlkMTJkZGM3YmNkMTdiMDRiNjU0ZGY0MzIzMHw5MzkzNDE7OTM5MzQxOzE0NDU1MTgzNTE7MjsxNDQ1NDMxOTUxLjkxNjtya3NoYXJlZGJveEBnbWFpbC5jb207ZGlzYWJsZWVudGl0bGVtZW50Ozs='
          }
        };
      }
    };
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.rest', []);
  module.service('playsReport', function(RestFactory) {
    return _.extend(this, {
      playsNumber: new RestFactory({
        params: {
          action: 'getTotal',
          reportType: 1
        }
      }),
      mediaEntriesNumber: new RestFactory({
        params: {
          action: 'getTable',
          reportType: 1
        }
      }),
      data: new RestFactory({
        params: {
          action: 'getGraphs',
          reportType: 1
        }
      })
    });
  });
  module.service('bandwidthReport', function(RestFactory) {
    return new RestFactory({
      params: {
        action: 'getGraphs',
        reportType: 201,
        'reportInputFilter:interval': 'months'
      }
    });
  });
  module.service('storageReport', function(RestFactory) {
    return new RestFactory({
      params: {
        action: 'getGraphs',
        reportType: 201,
        'reportInputFilter:interval': 'months'
      }
    });
  });
  module.service('transcodingConsumptionReport', function(RestFactory) {
    return new RestFactory({
      params: {
        action: 'getGraphs',
        reportType: 201,
        'reportInputFilter:interval': 'months'
      }
    });
  });
  return module.service('mediaEntriesReport', function(RestFactory) {
    return new RestFactory({
      params: {
        action: 'getGraphs',
        reportType: 5,
        'reportInputFilter:interval': 'days'
      }
    });
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.run', []);
  module.run(function(ArrayPrototype, StringPrototype, DatePrototype) {
    _.extend(Array.prototype, ArrayPrototype);
    _.extend(String.prototype, StringPrototype);
    return _.extend(Date.prototype, DatePrototype);
  });
  return module.run(function($window, utils) {
    $window.isMobileOrTablet = utils.navigator.isMobileOrTablet();
    return $window.isMobile = utils.navigator.isMobile();
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.services.go', []);
  return module.service('go', function($state) {
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
      })(this)
    });
  });
})();

(function() {
  var module;
  module = angular.module('KalturaUsageDashboard.utils', []);
  module.service('utils', function() {
    return {
      arrToObjByFn: function(arr, fn) {
        var i, j, len, obj;
        obj = {};
        for (j = 0, len = arr.length; j < len; j++) {
          i = arr[j];
          obj[fn(i)] = i;
        }
        return obj;
      },
      arrToObjByField: function(arr, field) {
        var i, j, len, obj;
        obj = {};
        for (j = 0, len = arr.length; j < len; j++) {
          i = arr[j];
          obj[i[field]] = i;
        }
        return obj;
      },
      arrToObjOfArrByField: function(arr, field) {
        var i, j, len, obj;
        obj = {};
        for (j = 0, len = arr.length; j < len; j++) {
          i = arr[j];
          if (obj[i[field]] == null) {
            obj[i[field]] = [];
          }
          obj[i[field]].push(i);
        }
        return obj;
      },
      arrToObj: function(arr) {
        var i, j, len, obj;
        obj = {};
        for (j = 0, len = arr.length; j < len; j++) {
          i = arr[j];
          obj[i] = i;
        }
        return obj;
      },
      objToArr: function(obj) {
        var arr, k, v;
        if (_.isArray(obj)) {
          return obj;
        }
        arr = [];
        for (k in obj) {
          v = obj[k];
          arr.push(v);
        }
        return arr;
      },
      parity: function(index) {
        if (index % 2) {
          return 'odd';
        } else {
          return 'even';
        }
      },
      navigator: {
        isMobileOrTablet: function() {
          var check;
          check = false;
          (function(a) {
            return check = /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4));
          })(navigator.userAgent || navigator.vendor || window.opera);
          return check;
        },
        isMobile: function() {
          var check;
          window.mobilecheck = function() {};
          check = false;
          (function(a) {
            return check = /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4));
          })(navigator.userAgent || navigator.vendor || window.opera);
          return check;
        }
      }
    };
  });
  return module.service('tryApply', function($rootScope) {
    return function(fn) {
      if ($rootScope.$$phase) {
        return fn();
      } else {
        return $rootScope.$apply(fn);
      }
    };
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
          templateUrl: 'app/scripts/pages/usage-dashboard/media-entries-report/media-entries-report.html'
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
    name: 'PlaysReportCtrl',
    injectToScope: ['playsReport'],
    fetch: function() {
      this._extractPayload();
      this._fetchPlaysNumber();
      this._fetchMediaEntriesNumber();
      return this._fetchData();
    },
    _extractPayload: function() {
      return this.payload = {
        'reportInputFilter:fromDay': 20150918,
        'reportInputFilter:toDay': 20151018
      };
    },
    _fetchPlaysNumber: function() {
      return this.playsReport.playsNumber.fetch(this.payload).then((function(_this) {
        return function(response) {
          return console.log(response);
        };
      })(this), (function(_this) {
        return function(response) {
          return console.log(response);
        };
      })(this));
    },
    _fetchMediaEntriesNumber: function() {
      return this.playsReport.mediaEntriesNumber.fetch(this.payload).then((function(_this) {
        return function(response) {
          return console.log(response);
        };
      })(this), (function(_this) {
        return function(response) {
          return console.log(response);
        };
      })(this));
    },
    _fetchData: function() {
      return this.playsReport.data.fetch(this.payload).then((function(_this) {
        return function(response) {
          return console.log(response);
        };
      })(this), (function(_this) {
        return function(response) {
          return console.log(response);
        };
      })(this));
    }
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
        pageTitle: 'Account Usage Reports'
      }
    });
  });
  return module.classy.controller({
    name: 'UsageDashboardCtrl'
  });
})();

(function() {
  var module;
  return module = angular.module('KalturaUsageDashboard', ['angular-flot', 'rt.select2', 'ui.date', 'ui.bootstrap', 'ui.router', 'restangular', 'classy', 'cb.x2js', 'ng-bundle-collection', 'KalturaUsageDashboard.kmc-config', 'KalturaUsageDashboard.config', 'KalturaUsageDashboard.constants', 'KalturaUsageDashboard.run', 'KalturaUsageDashboard.utils', 'KalturaUsageDashboard.rest', 'KalturaUsageDashboard.collections', 'KalturaUsageDashboard.directives.header', 'KalturaUsageDashboard.directives.side-menu', 'KalturaUsageDashboard.directives.datepicker', 'KalturaUsageDashboard.directives.graph', 'KalturaUsageDashboard.directives.report-controls', 'KalturaUsageDashboard.services.go', 'KalturaUsageDashboard.factories.rest', 'KalturaUsageDashboard.usage-dashboard']);
})();
