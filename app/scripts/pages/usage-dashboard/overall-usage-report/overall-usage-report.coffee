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
			'playsReport'
			'storageReport'
			'bandwidthReport'
			'transcodingConsumptionReport'
			'mediaEntriesReport'
			'users'
			'utils'
			'$q'
		]
		injectToScope: ['go']

		init: ->
			@_fetchCurrentMonth()
			@_fetchLastThreeMonths()
			@_fetchUsersTotal()

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
			@$q.all([
				@playsReport.graphData.fetch payload
				@storageReport.fetch payload
				@bandwidthReport.fetch payload
				@transcodingConsumptionReport.fetch payload
				@mediaEntriesReport.fetch payload
			]).then (responses) =>
				for i in [0..Date.nMonths params.from, params.to]
					result = {}
					for response in responses
						_.extend result, response[i]
					result

		_fetchUsersTotal: ->
			@users.total.fetch().then (response) =>
				@$.endUsers = response