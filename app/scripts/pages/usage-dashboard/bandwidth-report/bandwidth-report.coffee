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
				@$.months = _.extend response, dates: @$.dates

		getCsv: ->
			return unless @$.months?
			[
				[
					'Month'
					'Year'
					'Bandwidth Consumption (GB)'
				]
			].concat (
				for month in @$.months
					[
						@$filter('date') month.dates[0], 'MMMM'
						@$filter('date') month.dates[0], 'yyyy'
						month.bandwidth_consumption
					]
			)