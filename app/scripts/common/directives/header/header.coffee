do ->

	module = angular.module 'KalturaUsageDashboard.directives.header', [
		'classy'
	]

	module.directive 'header', ->
		replace: yes
		restrict: 'A'
		templateUrl: 'app/scripts/common/directives/header/header.html'
		controller: 'HeaderCtrl'

	module.classy.controller
		name: 'HeaderCtrl'
		inject: ['kmc']
		injectToScope: ['go']

		init: ->
			@$.items = @go.state().substates
			@$.helpHref = "#{@kmc.vars.service_url}/content/docs/NetHelp/default.htm#!Documents/contentreports.htm"