do ->

	module = angular.module 'KalturaUsageDashboard.rest.users', []

	module.service 'users', [
		'users.total',
		(total) ->
			total: total
	]

	module.service 'users.total', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					service: 'user'
					action: 'list'
					'pager:pageIndex': 1
					'pager:pageSize': 1

			@addFetchInterceptor (response) =>
				parseInt response.totalCount

			@
	]