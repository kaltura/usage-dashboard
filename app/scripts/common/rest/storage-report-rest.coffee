do ->

	module = angular.module 'KalturaUsageDashboard.rest.storage-report', []


	module.service 'storageReport', [
		'RestFactory'
		(RestFactory) ->
			new RestFactory
				params:
					action: 'getGraphs'
					reportType: 201
					'reportInputFilter:interval': 'months'
	]