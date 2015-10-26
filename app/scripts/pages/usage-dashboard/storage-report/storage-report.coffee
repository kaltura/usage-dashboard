do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.storage-report', ['classy']

	module.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider.state 'usage-dashboard.storage',
				url: '/storage'
				views:
					main:
						controller: 'StorageReportCtrl'
						templateUrl: 'app/scripts/pages/usage-dashboard/storage-report/storage-report.html'
				data:
					pageTitle: 'Storage Report'
	]

	module.classy.controller
		name: 'StorageReportCtrl'
		inject: ['storageReport', 'utils', '$filter']

		fetch: ->
			@_extractPayload()
			@_fetchData()

		_extractPayload: ->
			@payload =
				'reportInputFilter:fromDay': @$.dates.from.toYMDn()
				'reportInputFilter:toDay': @$.dates.to.toYMDn()

		_fetchData: ->
			@$.months = null
			@storageReport.fetch(@payload).then (response) =>
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
					'Average Storage'
				]
			].concat (
				for month in @$.months
					[
						month.label
						month.value
					]
			)