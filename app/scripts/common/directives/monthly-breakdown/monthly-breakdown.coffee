do ->

	module = angular.module 'KalturaUsageDashboard.directives.monthly-breakdown', ['classy']

	module.constant 'monthlyBreakdownColumns',
		default: [
			title: 'Month'
			field: 'label'
		]
		reports:
			plays: [
				title: 'Plays'
				field: 'count_plays'
			]
			storage: [
				title: 'Average Storage (GB)'
				field: 'average_storage'
			]
			bandwidth: [
				title: 'Bandwidth Consumption (GB)'
				field: 'bandwidth_consumption'
			]
			'transcoding-consumption': [
				title: 'Transcoding Consumption (GB)'
				field: 'transcoding_consumption'
			]
			'media-entries': [
				title: 'Total'
				field: 'count_total'
			,
				title: 'Video'
				field: 'count_video'
			,
				title: 'Audio'
				field: 'count_audio'
			,
				title: 'Images'
				field: 'count_image'
			]

	module.directive 'monthlyBreakdown', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/monthly-breakdown/monthly-breakdown.html'
		controller: 'MonthlyBreakdownCtrl'
		scope:
			name: '@monthlyBreakdown'
			months: '='
			cls: '@'

	module.classy.controller
		name: 'MonthlyBreakdownCtrl'
		injectToScope: ['monthlyBreakdownColumns']

		init: ->
			@_determineColumns()

		_determineColumns: ->
			@$.columns = @monthlyBreakdownColumns.default.concat @monthlyBreakdownColumns.reports[@$.name]