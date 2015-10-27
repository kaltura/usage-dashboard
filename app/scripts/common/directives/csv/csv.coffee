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
		inject: ['constants', '$filter']

		getCsvArray: ->
			columns = @constants.columns.reports[@$.name]
			[
				[
					'Month'
					'Year'
				].concat (column.title for column in columns)
			].concat (
				for month in @$.months
					[
						@$filter('date') month.dates[0], 'MMMM'
						@$filter('date') month.dates[0], 'yyyy'
					].concat (month[column.field] for column in columns)
			)