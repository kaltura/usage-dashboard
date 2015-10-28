do ->

	module = angular.module 'KalturaUsageDashboard.rest.storage-report', []


	module.service 'storageReport', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getGraphs'
					reportType: 201
					'reportInputFilter:interval': 'days'

			modifiers = @modifiers 'average_storage'

			@addFetchInterceptor modifiers.extract.months
			@addFetchInterceptor modifiers.convert.MBtoGB

			@
	]