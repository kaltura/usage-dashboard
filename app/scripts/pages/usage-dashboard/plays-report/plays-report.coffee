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
				@$.months = {}
				nMonths = 0
				for day in response
					monthMark = day.date.toYM()
					unless @$.months[monthMark]?
						@$.months[monthMark] =
							label: @$filter('date') day.date, 'MMMM, yyyy'
							dates: []
							value: 0
						nMonths++
					@$.months[monthMark].dates.push day.date
					@$.months[monthMark].value += parseInt day.value
				for k, month of @$.months
					if month.dates.length isnt month.dates[0].nDaysInMonth()
						firstDate = month.dates[0].getDate()
						lastDate = month.dates[month.dates.length-1].getDate()
						month.label = "#{firstDate} #{if firstDate isnt lastDate then '-' + lastDate else ''} #{month.label}"



			# @$.numbers = {}
			# d = new Date @$.dates.from
			# while d.toYM() <= @$.dates.to.toYM()
			# 	do =>
			# 		from = new Date d
			# 		from.setDate 1
			# 		to = new Date d
			# 		to.setMonth to.getMonth() + 1
			# 		to.setDate 0
			# 		payload =
			# 			'reportInputFilter:fromDay': from.toYMDn()
			# 			'reportInputFilter:toDay': to.toYMDn()
			# 		@playsReport.playsNumber.fetch(payload).then (response) =>
			# 			@$.numbers[from.toYM()] = response
			# 		d.setMonth d.getMonth() + 1