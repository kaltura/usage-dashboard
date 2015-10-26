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
		'cb.x2js'
		'ng-bundle-collection'
		#common
		'KalturaUsageDashboard.kmc-config'
		'KalturaUsageDashboard.config'
		'KalturaUsageDashboard.constants'
		'KalturaUsageDashboard.run'
		'KalturaUsageDashboard.utils'
		'KalturaUsageDashboard.rest'
		'KalturaUsageDashboard.collections'
		#directives
		'KalturaUsageDashboard.directives.header'
		'KalturaUsageDashboard.directives.side-menu'
		'KalturaUsageDashboard.directives.datepicker'
		'KalturaUsageDashboard.directives.graph'
		'KalturaUsageDashboard.directives.report-controls'
		#services
		'KalturaUsageDashboard.services.go'
		#factories
		'KalturaUsageDashboard.factories.rest'
		'KalturaUsageDashboard.factories.module-consolidator'
		#pages
		'KalturaUsageDashboard.usage-dashboard'
	]