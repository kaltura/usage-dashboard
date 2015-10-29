do ->

	module = angular.module 'KalturaUsageDashboard.services.go', []

	module.service 'go', [
		'$state'
		'$location'
		($state, $location) ->
			_.extend @,
				current: -> _.extend {}, $state.current, $state.current

				go: (name) -> $state.transitionTo name, {}, inherit: yes

				path: =>
					switch arguments.length
						when 0 then @$location.path
						when 1
							item = arguments[0]
							target = $state.href item.name
							$location.path target

				$state: $state

				state: (name) =>
					_.extend $state.get(name) or {},
						substates: (@state state.name for state in $state.get() when state.name.contains(name or '') and state.name.length and state.name.nPoints() is if name? then name.nPoints()+1 else 0) or []

				# loading flags control

				flags:
					loading: 0

				inc: (n=1) => @flags.loading += n

				dec: (n=1) => @flags.loading -= n

				isLoading: =>
					for key, value of @flags
						return yes if value > 0
					no
	]