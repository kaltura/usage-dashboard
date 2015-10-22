do ->

	module = angular.module 'KalturaUsageDashboard.rest.media-entries-report', []


	module.service 'mediaEntriesReport', (RestFactory) ->
		new RestFactory
			params:
				action: 'getGraphs'
				reportType: 5
				'reportInputFilter:interval': 'days'