do ->

	module = angular.module 'KalturaUsageDashboard.directives.monthly-breakdown', ['classy']

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
		inject: ['constants']

		init: ->
			@_determineColumns()

		_determineColumns: ->
			@$.columns = @constants.columns.default.concat @constants.columns.reports[@$.name]