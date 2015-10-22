do ->

	module = angular.module 'KalturaUsageDashboard.rest.media-entries-report', []


	module.service 'mediaEntriesReport', [
		'RestFactory'
		(RestFactory) ->
			new RestFactory
				params:
					action: 'getGraphs'
					reportType: 5
					'reportInputFilter:interval': 'days'
	]