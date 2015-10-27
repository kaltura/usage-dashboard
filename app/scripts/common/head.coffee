do ->

	module = angular.module 'KalturaUsageDashboard.head', ['classy']

	module.classy.controller
		name: 'HeadCtrl'
		injectToScope: ['go']