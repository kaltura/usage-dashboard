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
		injectToScope: ['utils']

		init: ->
			@output = @$filter 'output'
			@date = @$filter 'date'

			if @utils.navigator.isIE9orLess()
				Downloadify.create 'downloadify',
					filename: @$.filename_
					data: =>
						columns = @_columns()
						data = "Month;Year"
						for column in columns
							data +=";#{column.title}"
						for month in @$.months
							str = "#{@date month.dates[0], 'MMMM'};#{@date month.dates[0], 'yyyy'}"
							for column in columns
								str += ";#{@output month[column.field]}"
							data += "\n#{str}"
						data
					swf: 'bower_components/Downloadify/media/downloadify.swf'
					transparent: yes
					downloadImage: 'bower_components/Downloadify/images/download.png'
					width: 100
					height: 30
					append: no

		filename_: ->
			"kaltura-#{@$.filename or @$.name}-report.csv"

		_columns: ->
			@constants.columns.reports[@$.name]

		exportCsv: ->
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
				if @utils.navigator.isIE9orLess()
					angular.element('#downloadify object').click()
					null
				else
					columns = @_columns()
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