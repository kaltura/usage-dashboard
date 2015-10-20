do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard', [
		'classy'
		'KalturaUsageDashboard.usage-dashboard.overall-usage-report'
		'KalturaUsageDashboard.usage-dashboard.plays-report'
		'KalturaUsageDashboard.usage-dashboard.storage-report'
		'KalturaUsageDashboard.usage-dashboard.bandwidth-report'
		'KalturaUsageDashboard.usage-dashboard.transcoding-consumption-report'
		'KalturaUsageDashboard.usage-dashboard.media-entries-report'
	]

	module.config ($stateProvider, $urlRouterProvider) ->
		$stateProvider.state 'usage-dashboard',
			url: '/usage-dashboard'
			views:
				main:
					controller: 'UsageDashboardCtrl'
					templateUrl: 'app/scripts/pages/usage-dashboard/usage-dashboard.html'
			data:
				pageTitle: 'Account Usage Reports'


	module.classy.controller
		name: 'UsageDashboardCtrl'
