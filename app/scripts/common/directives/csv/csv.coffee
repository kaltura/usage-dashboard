do ->

	module = angular.module 'KalturaUsageDashboard.directives.csv', ['classy']

	module.directive 'csv', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/csv/csv.html'
		controller: 'CsvCtrl'
		scope:
			filename: '@'
			name: '@csv'
			months: '='

	module.classy.controller
		name: 'CsvCtrl'
		inject: ['constants', '$filter', 'modals', 'constants']
		init: ->
			@output = @$filter 'output'
			@date = @$filter 'date'

		getCsvArray: ->
			from = @$.months[0].dates[0]
			to = @$.months[@$.months.length - 1].dates[@$.months[@$.months.length - 1].dates.length - 1]
			@modals.confirm.open(
				message: """
					<div>You are going to download <b>#{@constants.reports[@$.name].name}</b> in .csv format.</div>
					<div>Period: <b>#{@date from}#{if from.toYMD() isnt to.toYMD() then ' - ' + @date to else ''}</b></div>
					<div>Proceed?</div>
				"""
				title: 'Export CSV'
			).result.then =>
				columns = @constants.columns.reports[@$.name]
				[
					[
						'Month'
						'Year'
					].concat (column.title for column in columns)
				].concat (
					for month in @$.months
						[
							@date month.dates[0], 'MMMM'
							@date month.dates[0], 'yyyy'
						].concat (@output month[column.field] for column in columns)
				)