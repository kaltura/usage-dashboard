do ->

	module = angular.module 'KalturaUsageDashboard.rest.bandwidth-report', []


	module.service 'bandwidthReport', [
		'RestFactory'
		(RestFactory) ->
			new RestFactory
				params:
					action: 'getGraphs'
					reportType: 201
					'reportInputFilter:interval': 'months'
	]