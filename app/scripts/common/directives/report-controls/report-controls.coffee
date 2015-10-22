do ->

	module = angular.module 'KalturaUsageDashboard.directives.report-controls', ['classy']

	module.directive 'reportControls', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/report-controls/report-controls.html'
		controller: 'ReportControlsCtrl'
		scope:
			range: '=?'
			dates: '=?'
			changed: '&'
			disabled: '='

	module.classy.controller
		name: 'ReportControlsCtrl'
		injectToScope: ['reportControlsSelectCollection']

		init: ->
			@$.select =
				data: @reportControlsSelectCollection.arr
				options:
					allowClear: no
					placeholder: 'Select period...'
					minimumResultsForSearch: -1
			@$.select.model = @reportControlsSelectCollection.singleWhere(default: yes).id
			@$.dates =
				low: new Date
				high: new Date
			@$.changed?()

		watch:
			'select.model': (value, old) ->
				return if value is old or not value?
				@$.range = @reportControlsSelectCollection.by value
				@$.changed?()

			'dates.low': (value, old) ->
				return if value is old or not value?
				@$.changed?() if value?

			'dates.high': (value, old) ->
				return if value is old or not value?
				@$.changed?() if value?