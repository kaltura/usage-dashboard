do ->

	module = angular.module 'KalturaUsageDashboard.directives.html-bind-compile', []

	module.directive 'htmlBindCompile', [
		'$compile'
		($compile) ->
			restrict: 'A'
			link: (scope, element, attrs) ->
				scope.$watch attrs.htmlBindCompile, (value, old) ->
					element.html value
					$compile(element.contents()) scope
	]