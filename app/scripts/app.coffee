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
		#common
		'KalturaUsageDashboard.config'
		'KalturaUsageDashboard.constants'
		'KalturaUsageDashboard.run'
		'KalturaUsageDashboard.utils'
		#directives
		'KalturaUsageDashboard.directives.header'
		'KalturaUsageDashboard.directives.side-menu'
		'KalturaUsageDashboard.directives.datepicker'
		#services
		'KalturaUsageDashboard.services.go'
		#pages
		'KalturaUsageDashboard.usage-dashboard'
	]

	module.classy.controller
		name: 'KalturaUsageDashboardCtrl'