do ->

	module = angular.module 'KalturaUsageDashboard.directives.side-menu', [
		'classy'
	]

	module.directive 'sideMenu', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/side-menu/side-menu.html'
		controller: 'SideMenuCtrl'

	module.classy.controller
		name: 'SideMenuCtrl'
