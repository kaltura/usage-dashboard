do ->

	module = angular.module 'KalturaUsageDashboard.directives.months-graph', ['classy']

	module.directive 'monthsGraph', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/graph/months-graph.html'
		controller: 'MonthsGraphCtrl'
		scope:
			data: '=monthsGraph'

	module.classy.controller
		name: 'MonthsGraphCtrl'

		