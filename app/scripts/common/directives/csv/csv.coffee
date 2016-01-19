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
			dates: '='

	module.classy.controller
		name: 'CsvCtrl'
		inject: [
			'vpaasUsageReport'
			'constants'
			'$filter'
			'modals'
			'constants'
		]
		injectToScope: ['utils']

		init: ->
			@output = @$filter 'output'
			@date = @$filter 'date'

		filename_: ->
			"kaltura-#{@$.filename or @$.name}-report.csv"

		_modal: ->
			from = @$.dates.from
			to = @$.dates.to
			@modals.confirm.open
				# message: """
				# 	<div>You are going to download <b>#{@constants.reports[@$.name].name}</b> in .csv format.</div>
				# 	<div>Period: <b>#{@date from}#{if from.toYMD() isnt to.toYMD() then ' - ' + @date to else ''}</b></div>
				# 	<div>Proceed?</div>
				# """
				message: """
					<div>You are going to download <b>full usage report</b> in .csv format for <b>#{@date from}#{if from.toYMD() isnt to.toYMD() then ' - ' + @date to else ''}</b>.</div>
					<div>Proceed?</div>
				"""
				title: 'Export CSV'

		export: ->
			@_modal().result.then =>
				@vpaasUsageReport.fetch(@utils.csv.extractPayload @$.dates, @$.name).then (response) =>
					# a = document.createElement 'a'
					# a.href = response
					# a.innerHtml = ' '
					# $a = angular.element a
					# $a.attr 'download', @$.filename_()
					# $a.attr 'href', response
					# $a.attr 'target', '_blank'
					# a[if navigator.isFF then 'onclick' else 'click']?()
					# a.dispatchEvent new Event 'click'
					# a.click()
					window.location.replace response
					# null