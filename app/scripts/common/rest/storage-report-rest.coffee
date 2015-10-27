do ->

	module = angular.module 'KalturaUsageDashboard.rest.storage-report', []


	module.service 'storageReport', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getGraphs'
					reportType: 201
					'reportInputFilter:interval': 'months'

			@addFetchInterceptor (response) =>
				@extract.graph(response, 'month').average_storage or []

			@
	]