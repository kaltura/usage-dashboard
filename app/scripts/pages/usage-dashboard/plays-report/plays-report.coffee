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
		inject: ['playsReport', 'utils', '$filter']

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
			@$.months = null
			@playsReport.graphData.fetch(@payload).then (response) =>
				months = {}
				days = @utils.arrToObjByFn response, (day) -> day.date.toYMD()
				date = new Date @$.dates.from
				while date.toYMDn() <= @$.dates.to.toYMDn()
					monthMark = date.toYM()
					unless months[monthMark]?
						months[monthMark] =
							label: @$filter('date') date, 'MMMM, yyyy'
							dates: []
							value: 0
					months[monthMark].dates.push new Date date
					months[monthMark].value += parseInt days[date.toYMD()]?.value or 0
					date.setDate date.getDate() + 1
				@$.months = @utils.objToArr months
				@$.months.dates = @$.dates