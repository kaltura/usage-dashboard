do ->

	module = angular.module 'KalturaUsageDashboard.rest.transcoding-consumption-report', []


	module.service 'transcodingConsumptionReport', (RestFactory) ->
		new RestFactory
			params:
				action: 'getGraphs'
				reportType: 201
				'reportInputFilter:interval': 'months'