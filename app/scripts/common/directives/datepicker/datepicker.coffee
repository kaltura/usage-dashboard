do ->

	module = angular.module 'KalturaUsageDashboard.directives.datepicker', [
		'classy'
	]

	module.directive 'kalturaDatepicker', ->
		restrict: 'A'
		replace: yes
		templateUrl: 'app/scripts/common/directives/datepicker/datepicker.html'
		controller: 'KalturaDatepickerCtrl'
		scope:
			model: '=kalturaDatepicker'
			disabled: '='
			min: '=?'
			max: '=?'
			name: '=?'

	module.classy.controller
		name: 'KalturaDatepickerCtrl'
		inject: ['$element', '$timeout']

		init: ->
			@input = @$element.find 'input'
			@$.options =
				changeYear: yes
				changeMonth: yes
				# yearRange: '2000:-0'
			@$.name = 'datepicker' unless @$.name
			@$timeout =>
				@_flushMin()
				@_flushMax()

		watch:
			min: (value) -> @_flushMin() if value

			max: (value) -> @_flushMax() if value

		_flushMin: ->
			@input.datepicker 'option', 'minDate', @$.min

		_flushMax: ->
			@input.datepicker 'option', 'maxDate', @$.max


		open: ->
			@input.datepicker 'show'
			null

		hide: ->
			@input.datepicker 'hide'
			null