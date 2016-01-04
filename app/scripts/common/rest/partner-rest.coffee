do ->

	module = angular.module 'KalturaUsageDashboard.rest.partner', []


	module.service 'partner', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					service: 'partner'
					action: 'getInfo'

			@extendFetch
				s: (response) =>
					@info = response

			@
	]