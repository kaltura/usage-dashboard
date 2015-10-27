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
			@payload = @utils.reports.extractPayload @$.dates

		_fetchData: ->
			@$.months = null
			@mediaEntriesReport.fetch(@payload).then (response) =>
				@$.months = _.extend response, dates: @$.dates