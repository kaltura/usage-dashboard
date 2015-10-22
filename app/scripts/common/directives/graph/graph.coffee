do ->

	module = angular.module 'KalturaUsageDashboard.directives.graph', ['classy']

	module.directive 'graph', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/graph/graph.html'
		controller: 'GraphCtrl'
		scope:
			data: '=graph'

	module.classy.controller
		name: 'GraphCtrl'
		inject: ['graph']

		init: ->

			data = [
				[0,	12]
				[1,	37]
				[2,	1]
				[3,	75]
			]

			@$.graph =
				data: [
					# label: '2012 Average Temperature'
					color: @graph.colorColumn
					data: data
					# shadowSize: 2
					# highlightColor: '#bbbbbb'
				]

				options:
					series:
						bars:
							show: yes
							fill: yes
							fillColor: @graph.colorColumn
						# points:
						# 	show: yes
						# 	radius: 3
						# 	lineWidth: 1
					tooltip:
						show: yes
						content: (label, x, y, flot) ->
							"""
								<div class='text'>#{flot.series.xaxis.ticks[flot.dataIndex].label}</div>
								<div class='value'>#{flot.series.data[flot.dataIndex][1]}</div>
							"""
						cssClass: 'graph-tooltip'
					bars:
						align: 'center'
						barWidth: 0.75
					xaxis:
						show: yes
						color: @graph.colorAxis
						axisLabel: 'Months'
						axisLabelUseCanvas: yes
						axisLabelFontSizePixels: 12
						axisLabelFontFamily: 'arial,sans serif'
						axisLabelPadding: 12
						ticks: [
							[0,	'August, 2015']
							[1,	'September, 2015']
							[2,	'October, 2015']
							[3,	'November, 2015']
						]
						tickLength: 0
						min: -0.5
						max: data.length - 0.5
					yaxis:
						axisLabel: 'Plays Number'
						color: @graph.colorAxis
						axisLabelUseCanvas: yes
						axisLabelFontSizePixels: 12
						axisLabelFontFamily: 'arial,sans serif'
						axisLabelPadding: 10
						# tickFormatter: (v, axis) -> v
						# alignTicksWithAxis: 10
						reserveSpace: yes
						tickLength: 15
						# tickSize: 5
						# min: -1
					legend:
						noColumns: 0
						labelBoxBorderColor: '#000000'
						position: 'nw'
					grid:
						show: yes
						hoverable: yes
						clickable: yes
						# mouseActiveRadius: 10
						borderWidth:
							top: 0
							right: 0
							bottom: @graph.borderWidth
							left: @graph.borderWidth
						borderColor: @graph.colorAxis
						backgroundColor: @graph.mainBg
						aboveData: no
						axisMargin: 10