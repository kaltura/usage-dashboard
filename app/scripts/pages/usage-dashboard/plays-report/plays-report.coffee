do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.plays-report', ['classy']

	module.config ($stateProvider) ->
		$stateProvider.state 'usage-dashboard.plays',
			url: '/plays'
			views:
				main:
					controller: 'PlaysReportCtrl'
					templateUrl: 'app/scripts/pages/usage-dashboard/plays-report/plays-report.html'
			data:
				pageTitle: 'Plays Report'

	module.classy.controller
		name: 'PlaysReportCtrl'