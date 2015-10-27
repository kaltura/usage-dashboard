do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.media-entries-report', ['classy']

	module.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider.state 'usage-dashboard.media-entries',
				url: '/media-entries'
				views:
					main:
						controller: 'MediaEntriesReportCtrl'
						templateUrl: 'app/scripts/pages/usage-dashboard/media-entries-report/media-entries-report.html'
				data:
					pageTitle: 'Media Entries Report'
	]

	module.classy.controller
		name: 'MediaEntriesReportCtrl'
		inject: ['mediaEntriesReport', 'utils', '$filter']

		fetch: ->
			@_extractPayload()
			@_fetchData()

		_extractPayload: ->
			@payload =
				'reportInputFilter:fromDay': @$.dates.from.toYMDn()
				'reportInputFilter:toDay': @$.dates.to.toYMDn()

		_fetchData: ->
			@$.months = null
			@mediaEntriesReport.fetch(@payload).then (response) =>
				@$.months = _.extend response, dates: @$.dates

		getCsv: ->
			return unless @$.months?
			[
				[
					'Month'
					'Year'
					'Total'
					'Video'
					'Audio'
					'Image'
				]
			].concat (
				for month in @$.months
					[
						@$filter('date') month.dates[0], 'MMMM'
						@$filter('date') month.dates[0], 'yyyy'
						month.count_total
						month.count_video
						month.count_audio
						month.count_image
					]
			)