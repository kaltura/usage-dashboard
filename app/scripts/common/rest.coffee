do ->

	module = angular.module 'KalturaUsageDashboard.rest', []

	module.service 'playsReport', (RestFactory) ->
		_.extend @,

			playsNumber: new RestFactory
				params:
					action: 'getTotal'
					reportType: 1

			mediaEntriesNumber: new RestFactory
				params:
					action: 'getTable'
					reportType: 1

			data: new RestFactory
				params:
					action: 'getGraphs'
					reportType: 1

	module.service 'bandwidthReport', (RestFactory) ->
		new RestFactory
			params:
				action: 'getGraphs'
				reportType: 201
				'reportInputFilter:interval': 'months'

	module.service 'storageReport', (RestFactory) ->
		new RestFactory
			params:
				action: 'getGraphs'
				reportType: 201
				'reportInputFilter:interval': 'months'

	module.service 'transcodingConsumptionReport', (RestFactory) ->
		new RestFactory
			params:
				action: 'getGraphs'
				reportType: 201
				'reportInputFilter:interval': 'months'

	module.service 'mediaEntriesReport', (RestFactory) ->
		new RestFactory
			params:
				action: 'getGraphs'
				reportType: 5
				'reportInputFilter:interval': 'days'