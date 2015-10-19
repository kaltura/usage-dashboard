do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.storage-report', ['classy']

	module.config ($stateProvider) ->
		$stateProvider.state 'usage-dashboard.storage',
			url: '/storage'
			views:
				main:
					controller: 'StorageReportCtrl'
					templateUrl: 'app/scripts/pages/usage-dashboard/storage-report/storage-report.html'
			data:
				pageTitle: 'Storage Report'

	module.classy.controller
		name: 'StorageReportCtrl'