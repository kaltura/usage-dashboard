do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.media-entries-report', ['classy']

	module.config ($stateProvider) ->
		$stateProvider.state 'usage-dashboard.media-entries',
			url: '/media-entries'
			views:
				main:
					controller: 'MediaEntriesReportCtrl'
					templateUrl: 'app/scripts/pages/usage-dashboard/media-entries/media-entries-report.html'
			data:
				pageTitle: 'Media Entries Report'

	module.classy.controller
		name: 'MediaEntriesReportCtrl'