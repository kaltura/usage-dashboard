do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.transcoding-consumption-report', ['classy']

	module.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider.state 'usage-dashboard.transcoding-consumption',
				url: '/transcoding-consumption'
				views:
					main:
						controller: 'TranscodingConsumptionReportCtrl'
						templateUrl: 'app/scripts/pages/usage-dashboard/transcoding-consumption-report/transcoding-consumption-report.html'
				data:
					pageTitle: 'Transcoding Consumption Report'
	]

	module.classy.controller
		name: 'TranscodingConsumptionReportCtrl'