do ->

	module = angular.module 'KalturaUsageDashboard.directives.overlay', []

	module.directive 'overlay', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/overlay/overlay.html'
		scope:
			show: '&overlay'
		link: (scope, element) -> element.parent().addClass 'overlay-parent'