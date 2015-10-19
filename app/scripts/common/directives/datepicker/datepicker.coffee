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
			model: '=datepicker'
			name: '=?'

	module.classy.controller
		name: 'KalturaDatepickerCtrl'
		inject: ['$element']

		init: ->
			@$.options =
				changeYear: yes
				changeMonth: yes
				yearRange: '2000:-0'
			@$.name = 'datepicker' unless @$.name
			@$.model = new Date unless @$.model

		open: ->
			@$element.find('input').datepicker 'show'
			null

		hide: ->
			@$element.find('input').datepicker 'hide'
			null