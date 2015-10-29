do ->

	module = angular.module 'KalturaUsageDashboard.services.redirector', []

	module.service 'redirector', [
		'$location'
		'$state'
		($location, $state) ->
			(name) ->
				url = $state.href name
				params = $location.search()
				unless _.isEmpty params
					url += '?'
					for k, v of params
						url += "#{k}=#{v}"
				url
	]