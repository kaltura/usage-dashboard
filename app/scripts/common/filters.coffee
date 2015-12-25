do ->

	module = angular.module 'KalturaUsageDashboard.filters', []

	module.filter 'output', [
		'$filter'
		($filter) ->
			nFilter = $filter 'number'
			(input, fraction=2) ->
				switch yes
					when _.isNumber input
						if input.isFloat()
							nFilter input, fraction
						else
							nFilter input, 0
					else
						input or 0
	]

	module.filter 'arr_reverse', [
		->
			(input) ->
				if _.isArray input
					for index in [input.length-1..0]
						input[index]
				else
					input
	]