do ->

	module = angular.module 'KalturaUsageDashboard.run', []

	module.run [
		'ArrayPrototype'
		'StringPrototype'
		'NumberPrototype'
		'NumberExtension'
		'DatePrototype'
		'DateExtension'
		(ArrayPrototype, StringPrototype, NumberPrototype, NumberExtension, DatePrototype, DateExtension) ->
			_.extend Array::, ArrayPrototype
			_.extend String::, StringPrototype
			_.extend Number::, NumberPrototype
			_.extend Number, NumberExtension
			_.extend Date::, DatePrototype
			_.extend Date, DateExtension
	]

	module.run [
		'$window'
		'utils'
		($window, utils) ->
			$window.isMobileOrTablet = utils.navigator.isMobileOrTablet()
			$window.isMobile = utils.navigator.isMobile()
	]