do ->

	module = angular.module 'KalturaUsageDashboard.rest.plays-report', []


	module.service 'playsReport.playsNumber', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getTotal'
					reportType: 1

			@addFetchInterceptor (response) =>
				parseInt @extract.dict(response).count_plays or 0

			@
	]


	module.service 'playsReport.mediaEntriesNumber', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getTable'
					reportType: 1
					'pager:objectType': 'KalturaFilterPager'
					'pager:pageIndex': 1
					'pager:pageSize': 1

			@addFetchInterceptor (response) =>
				parseInt response.totalCount or 0

			@
	]


	module.service 'playsReport.graphData', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getGraphs'
					reportType: 1
					'reportInputFilter:interval': 'days'

			@addFetchInterceptor (response) =>
				@extract.graph(response).count_plays or []

			@
	]


	module.service 'playsReport', [
		'playsReport.playsNumber'
		'playsReport.mediaEntriesNumber'
		'playsReport.graphData'
		(playsNumber, mediaEntriesNumber, graphData) ->
			playsNumber: playsNumber
			mediaEntriesNumber: mediaEntriesNumber
			graphData: graphData
	]