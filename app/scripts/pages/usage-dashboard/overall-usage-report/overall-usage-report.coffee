do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.overall-usage-report', ['classy']

	module.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider.state 'usage-dashboard.overall-usage',
				url: '/overall-usage'
				views:
					main:
						controller: 'OverallUsageReportCtrl'
						templateUrl: 'app/scripts/pages/usage-dashboard/overall-usage-report/overall-usage-report.html'
				data:
					pageTitle: 'Overall Usage Report'
	]

	module.classy.controller
		name: 'OverallUsageReportCtrl'
		inject: [
			'vpaasUsageReport'
			'utils'
			'$q'
		]
		injectToScope: ['go']

		init: ->
			@_fetchCurrentMonth()
			@_fetchLastThreeMonths()

		_fetchCurrentMonth: ->
			@__fetch(
				from: (new Date).toMonthStart()
				to: new Date
			).then (result) =>
				@$.currentMonth = result[0]

		_fetchLastThreeMonths: ->
			@__fetch(
				from: (new Date).subMonth(2).toMonthStart()
				to: new Date
			).then (result) =>
				@$.lastThreeMonths = result


		__fetch: (params) ->
			payload = @utils.reports.extractPayload params
			@vpaasUsageReport.fetch payload