do ->

	module = angular.module 'KalturaUsageDashboard.directives.report-controls', ['classy']

	module.directive 'reportControls', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/report-controls/report-controls.html'
		controller: 'ReportControlsCtrl'
		scope:
			from: '=?'
			to: '=?'
			changed: '&'
			disabled: '='

	module.classy.controller
		name: 'ReportControlsCtrl'
		inject: ['$timeout']
		injectToScope: ['reportControlsSelectCollection', 'go']

		init: ->
			@_initParams()

		watch:
			'select.model': (value, old) ->
				return if value is old or not value?
				@_calcRange()
				@_changed()

			'dates.low': (value, old) ->
				return if value is old or not value?
				@_calcFrom()
				@_changed()

			'dates.high': (value, old) ->
				return if value is old or not value?
				@_calcTo()
				@_changed()

		_initParams: ->
			@$.select =
				data: @reportControlsSelectCollection.arr
				options:
					allowClear: no
					placeholder: 'Select period...'
					minimumResultsForSearch: -1
				model: @reportControlsSelectCollection.singleWhere(default: yes).id
			@$.dates =
				low: new Date
				high: new Date
			@_calcRange()
			@_changed()

		_changed: ->
			@$timeout =>
				@$.changed?()

		_calcRange: ->
			@$.range = @reportControlsSelectCollection.by @$.select.model
			@_calcFrom()
			@_calcTo()

		_calcFrom: ->
			@$.from = if @$.range.allowDatepickers
				@$.dates.low
			else
				@$.range.dates.low()

		_calcTo: ->
			@$.to = if @$.range.allowDatepickers
				@$.dates.high
			else
				@$.range.dates.high()