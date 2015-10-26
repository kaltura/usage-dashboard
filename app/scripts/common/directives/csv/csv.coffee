do ->

	module = angular.module 'KalturaUsageDashboard.directives.csv', []

	module.directive 'csv', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/csv/csv.html'
		scope:
			name: '@'
			getArray: '&csv'
			disabled: '='