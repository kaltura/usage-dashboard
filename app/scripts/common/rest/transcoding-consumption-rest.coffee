do ->

	module = angular.module 'KalturaUsageDashboard.rest.transcoding-consumption-report', []


	module.service 'transcodingConsumptionReport', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getGraphs'
					reportType: 201
					'reportInputFilter:interval': 'days'

			modifiers = @modifiers 'transcoding_consumption'

			@addFetchInterceptor modifiers.extract.months
			@addFetchInterceptor modifiers.convert.MBtoGB

			@
	]