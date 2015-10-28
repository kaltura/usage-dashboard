do ->

	module = angular.module 'KalturaUsageDashboard.rest.bandwidth-report', []


	module.service 'bandwidthReport', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getGraphs'
					reportType: 201
					'reportInputFilter:interval': 'days'

			modifiers = @modifiers 'bandwidth_consumption'

			@addFetchInterceptor modifiers.extract.months
			@addFetchInterceptor modifiers.convert.MBtoGB

			@
	]