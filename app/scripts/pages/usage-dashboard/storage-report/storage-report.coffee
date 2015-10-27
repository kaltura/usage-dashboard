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
				@$.months = _.extend response, dates: @$.dates

		getCsv: ->
			return unless @$.months?
			[
				[
					'Month'
					'Year'
					'Average Storage (MB)'
				]
			].concat (
				for month in @$.months
					[
						@$filter('date') month.dates[0], 'MMMM'
						@$filter('date') month.dates[0], 'yyyy'
						month.value
					]
			)