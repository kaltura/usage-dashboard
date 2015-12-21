do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.plays-report', ['classy']

	module.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider.state 'usage-dashboard.plays',
				url: '/plays'
				views:
					main:
						controller: 'PlaysReportCtrl'
						templateUrl: 'app/scripts/pages/usage-dashboard/plays-report/plays-report.html'
				data:
					pageTitle: 'Plays Report'
	]

	module.classy.controller
		name: 'PlaysReportCtrl'
		inject: [
			'utils'
			'vpaasUsageReport'
		]

		fetch: ->
			@_extractPayload()
			@_fetchPlaysNumber()
			@_fetchMediaEntriesNumber()
			@_fetchData()

		_extractPayload: ->
			@payload = @utils.reports.extractPayload @$.dates

		_fetchPlaysNumber: ->
			@vpaasUsageReport.plays.number(@payload).then (response) =>
				@$.playsNumber = response

		_fetchMediaEntriesNumber: ->
			@vpaasUsageReport.plays.mediaEntriesNumber(@payload).then (response) =>
				@$.mediaEntriesNumber = response

		_fetchData: ->
			@$.months = null
			@vpaasUsageReport.plays.data(@payload).then (response) =>
				@$.months = _.extend response, dates: @$.dates