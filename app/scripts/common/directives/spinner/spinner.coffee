do ->

	module = angular.module 'KalturaUsageDashboard.directives.spinner', ['classy']

	module.directive 'spinner', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/spinner/spinner.html'
		controller: 'SpinnerCtrl'
		scope: yes

	module.classy.controller
		name: 'SpinnerCtrl'
		injectToScope: ['go']