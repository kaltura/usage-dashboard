do ->

	module = angular.module 'KalturaUsageDashboard.rest.end-users-report', []


	module.service 'endUsersReport', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getGraphs'
					reportType: 5
					'reportInputFilter:interval': 'days'

			@
	]