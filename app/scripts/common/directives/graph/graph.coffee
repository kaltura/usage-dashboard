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

		watch:
			data: (value) -> 
				if value? and not _.isEmpty value
					@_buildGraphData()
				else
					@$.graph = null
				
		_buildGraphData: ->
			data = []
			xaxisTicks = []
			index = 0
			maxDataValue = 0
			for k, month of @$.data
				data.push [
					index
					month.value
				]
				xaxisTicks.push [
					index
					month.label
				]
				if maxDataValue < month.value
					maxDataValue = month.value
				index++

			str = maxDataValue.toString()
			rank = Math.pow 10, (str.length - 1) or 1
			maxYTick = parseInt(str[0]) * rank or 10
			maxYTick+=rank if maxYTick < maxDataValue

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
						# axisLabelUseCanvas: yes
						axisLabelFontSizePixels: 12
						axisLabelFontFamily: 'arial,sans serif'
						axisLabelPadding: 20
						ticks: xaxisTicks
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
						# alignTicksWithAxis: 10
						reserveSpace: yes
						tickLength: 15
						tickSize: rank/2
						max: maxYTick
						tickFormatter: (val) ->
							"<p>#{if val % rank then '' else val}</p>"
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

			# @$.graph.options.xaxis.rotateTicks = switch yes
			# 	when 8 <= data.length < 12 then 30
			# 	when 12 <= data.length < 20 then 45
			# 	when 20 <= data.length then 60