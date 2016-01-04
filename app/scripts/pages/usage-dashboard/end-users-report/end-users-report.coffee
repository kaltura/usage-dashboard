do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.end-users-report', ['classy']

	module.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider.state 'usage-dashboard.end-users',
				url: '/end-users'
				views:
					main:
						controller: 'EndUsersReportCtrl'
						templateUrl: 'app/scripts/pages/usage-dashboard/end-users-report/end-users-report.html'
				data:
					pageTitle: 'End Users Report'
	]

	module.classy.controller
		name: 'EndUsersReportCtrl'
		inject: [
			'vpaasUsageReport'
			'utils'
		]

		fetch: ->
			@_extractPayload()
			@_fetchData()

		_extractPayload: ->
			@payload = @utils.reports.extractPayload @$.dates

		_fetchData: ->
			@$.months = null
			@vpaasUsageReport.users(@payload).then (response) =>
				@$.months = _.extend response, dates: @$.dates