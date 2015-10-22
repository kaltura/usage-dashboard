do ->

	module = angular.module 'KalturaUsageDashboard.run', []

	module.run [
		'ArrayPrototype'
		'StringPrototype'
		'DatePrototype'
		(ArrayPrototype, StringPrototype, DatePrototype) ->
			_.extend Array::, ArrayPrototype
			_.extend String::, StringPrototype
			_.extend Date::, DatePrototype
	]

	module.run [
		'$window'
		'utils'
		($window, utils) ->
			$window.isMobileOrTablet = utils.navigator.isMobileOrTablet()
			$window.isMobile = utils.navigator.isMobile()
	]