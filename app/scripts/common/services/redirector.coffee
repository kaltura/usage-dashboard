do ->

	module = angular.module 'KalturaUsageDashboard.services.redirector', []

	module.service 'redirector', [
		'$location'
		'$state'
		($location, $state) ->
			(name) ->
				url = $state.href name
				regex = new RegExp "^#{angular.element('base').attr('href')}"
				url.replace regex, ''
				params = $location.search()
				unless _.isEmpty params
					url += '?'
					for k, v of params
						url += "#{k}=#{v}"
				url
	]