do ->

	module = angular.module 'KalturaUsageDashboard.collections', []

	module.service 'reportControlsSelectCollection', (Collection) ->
		_.extend @, new Collection
		@add [
			id: 0
			name: 'Last month'
		,
			id: 1
			name: 'Last 3 months'
			default: yes
		,
			id: 2
			name: 'Custom date range by month'
			allowDatepickers: yes
		]
		@