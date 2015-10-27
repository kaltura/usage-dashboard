do ->

	module = angular.module 'KalturaUsageDashboard.rest.transcoding-consumption-report', []


	module.service 'transcodingConsumptionReport', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getGraphs'
					reportType: 201
					'reportInputFilter:interval': 'months'

			@addFetchInterceptor (response, payload) =>
				@extract.months response, payload, 'transcoding_consumption'

			@
	]