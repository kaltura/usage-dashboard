do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.bandwidth-report', ['classy']

	module.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider.state 'usage-dashboard.bandwidth',
				url: '/bandwidth'
				views:
					main:
						controller: 'BandwidthReportCtrl'
						templateUrl: 'app/scripts/pages/usage-dashboard/bandwidth-report/bandwidth-report.html'
				data:
					pageTitle: 'Bandwidth Report'
	]

	module.classy.controller
		name: 'BandwidthReportCtrl'