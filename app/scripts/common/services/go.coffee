do ->

	module = angular.module 'KalturaUsageDashboard.services.go', []

	module.service 'go', ($state) ->
		_.extend @,
			current: -> $state.current

			go: -> $state.go arguments...

			$state: $state

			state: (name) =>
				_.extend $state.get(name),
					substates: (@state state for state in $state.get() when state.name.includes(name or '') and state.name.length and state.name.nPoints() is (name?.nPoints()+1) or 0) or []
