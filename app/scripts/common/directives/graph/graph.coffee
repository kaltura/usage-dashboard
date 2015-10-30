do ->

	module = angular.module 'KalturaUsageDashboard.directives.graph', ['classy']

	module.directive 'graph', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/graph/graph.html'
		controller: 'GraphCtrl'
		scope:
			data: '=graph'
			units: '@'
			yLabel: '@'
			valueField: '@'
			labelField: '@'

	module.classy.controller
		name: 'GraphCtrl'
		inject: ['$filter']
		injectToScope: ['constants']
		init: ->
			@output = @$filter 'output'

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
			for month in @$.data
				data.push [
					index
					month[@$.valueField or 'value']
				]
				xaxisTicks.push [
					index
					month[@$.labelField or 'label']
				]
				if maxDataValue < month[@$.valueField or 'value']
					maxDataValue = month[@$.valueField or 'value']
				index++

			str = parseInt(maxDataValue).toString()
			rank = Math.pow 10, (str.length - 1) or 1
			tickSize = rank/2
			maxYTick = parseInt(str[0]) * rank or 10
			maxYTick+=rank if maxYTick < maxDataValue

			while maxYTick/tickSize <= 10 and tickSize/2 is Math.floor tickSize/2
				tickSize /= 2

			@$.graph =
				data: [
					# label: '2012 Average Temperature'
					color: @constants.graph.colorColumn
					data: data
					# shadowSize: 2
					# highlightColor: '#bbbbbb'
				]

				options:
					series:
						bars:
							show: yes
							lineWidth: 0
							fill: yes
							fillColor: @constants.graph.colorColumn
						# points:
						# 	show: yes
						# 	radius: 3
						# 	lineWidth: 1
					tooltip:
						show: yes
						content: (label, x, y, flot) =>
							"""
								<div class='text'>#{flot.series.xaxis.ticks[flot.dataIndex].label}</div>
								<div class='value'>#{@output flot.series.data[flot.dataIndex][1]} #{@$.units or ''}</div>
							"""
						cssClass: 'graph-tooltip'
					bars:
						align: 'center'
						barWidth: 0.75
					xaxis:
						show: yes
						color: @constants.graph.colorAxis
						ticks: xaxisTicks
						tickLength: 0
						min: -0.5
						max: data.length - 0.5
					yaxis:
						show: yes
						axisLabel: "#{@$.yLabel or ''} #{@$.units or ''}"
						color: @constants.graph.colorAxis
						axisLabelUseCanvas: yes
						axisLabelFontSizePixels: 12
						axisLabelFontFamily: 'arial,sans serif'
						axisLabelPadding: 10
						axisLabelColour: @constants.graph.colorText
						# alignTicksWithAxis: 10
						reserveSpace: yes
						tickLength: 15
						tickSize: tickSize
						max: maxYTick
						tickFormatter: (val) =>
							"<p>#{if val % (tickSize*2) then '' else @output val}</p>"
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
							bottom: @constants.graph.borderWidth
							left: @constants.graph.borderWidth
						borderColor: @constants.graph.colorAxis
						backgroundColor: @constants.graph.mainBg
						aboveData: no
						axisMargin: 10

			# @$.graph.options.xaxis.rotateTicks = switch yes
			# 	when 8 <= data.length < 12 then 30
			# 	when 12 <= data.length < 20 then 45
			# 	when 20 <= data.length then 60