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
		inject: ['bandwidthReport', 'utils', '$filter']

		fetch: ->
			@_extractPayload()
			@_fetchData()

		_extractPayload: ->
			@payload =
				'reportInputFilter:fromDay': @$.dates.from.toYMDn()
				'reportInputFilter:toDay': @$.dates.to.toYMDn()

		_fetchData: ->
			@$.months = null
			@bandwidthReport.fetch(@payload).then (response) =>
				months = @utils.arrToObjByFn response, (month) =>
					_.extend month,
						label: @$filter('date') month.date, 'MMMM, yyyy'
						value: parseFloat(month.value).toFixed 2
						dates: []
					month.date.toYM()
				date = new Date @$.dates.from
				while date.toYMDn() <= @$.dates.to.toYMDn()
					monthMark = date.toYM()
					months[monthMark].dates.push new Date date
					date.setDate date.getDate() + 1
				@$.months = @utils.objToArr months
				@$.months.dates = @$.dates

		getCsv: ->
			return unless @$.months?
			[
				[
					'Month'
					'Bandwidth Consumption (MB)'
				]
			].concat (
				for month in @$.months
					[
						month.label
						month.value
					]
			)