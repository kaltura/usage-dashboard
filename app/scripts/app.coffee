do ->

	module = angular.module 'KalturaUsageDashboard', [
		#assets
		'angular-flot'
		'rt.select2'
		'ui.date'
		'ui.bootstrap'
		'ui.router'
		'restangular'
		'classy'
		#config
		'KalturaUsageDashboard.config'
		#directives
		'KalturaUsageDashboard.directives.header'
		'KalturaUsageDashboard.directives.side-menu'
		'KalturaUsageDashboard.directives.datepicker'
		#pages
		'KalturaUsageDashboard.usage-dashboard'
	]

	module.classy.controller
		name: 'KalturaUsageDashboardCtrl'