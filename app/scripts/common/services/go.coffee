do ->

	module = angular.module 'KalturaUsageDashboard.services.go', []

	module.service 'go', ($state) ->
		_.extend @,
			current: -> $state.current

			go: -> $state.go arguments...

			$state: $state

			state: (name) =>
				_.extend $state.get(name) or {},
					substates: (@state state.name for state in $state.get() when state.name.includes(name or '') and state.name.length and state.name.nPoints() is if name? then name.nPoints()+1 else 0) or []