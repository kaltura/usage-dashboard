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
