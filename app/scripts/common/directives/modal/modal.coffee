do ->

	module = angular.module 'KalturaUsageDashboard.directives.modal', ['classy']

	module.directive 'modal', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/modal/modal.html'
		transclude: yes
		scope:
			ttl: '='
			okText: '='
			cancelText: '='