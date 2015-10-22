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
		inject: ['playsReport']

		fetch: ->
			@_extractPayload()
			@_fetchPlaysNumber()
			@_fetchMediaEntriesNumber()
			@_fetchData()

		_extractPayload: ->
			@payload =
				'reportInputFilter:fromDay': @$.dates.from.toYMDn()
				'reportInputFilter:toDay': @$.dates.to.toYMDn()

		_fetchPlaysNumber: ->
			@playsReport.playsNumber.fetch(@payload).then (response) =>
				@$.playsNumber = response

		_fetchMediaEntriesNumber: ->
			@playsReport.mediaEntriesNumber.fetch(@payload).then (response) =>
				@$.mediaEntriesNumber = response

		_fetchData: ->
			@playsReport.data.fetch(@payload).then (response) =>
				console.log response