do ->

	module = angular.module 'KalturaUsageDashboard.services.redirector', []

	module.service 'redirector', [
		'$location'
		'go'
		($location, go) ->
			(name) ->
				url = go.stateHref name
				params = $location.search()
				unless _.isEmpty params
					url += '?'
					for k, v of params
						url += "#{k}=#{v}"
				url
	]