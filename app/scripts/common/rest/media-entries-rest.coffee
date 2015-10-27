do ->

	module = angular.module 'KalturaUsageDashboard.rest.media-entries-report', []


	module.service 'mediaEntriesReport', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getGraphs'
					reportType: 5
					'reportInputFilter:interval': 'days'

			@addFetchInterceptor (response, payload) =>
				@extract.months response, payload, [
					'count_total'
					'count_video'
					'count_audio'
					'count_image'
				]

			@
	]