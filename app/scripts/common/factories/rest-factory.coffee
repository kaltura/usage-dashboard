do ->

	module = angular.module 'KalturaUsageDashboard.factories.rest', []

	module.factory 'RestFactory', [
		'Restangular'
		'Collection'
		'x2js'
		'go'
		'kmc'
		'utils'
		'$filter'
		(Restangular, Collection, x2js, go, kmc, utils, $filter) ->
			(config) ->
				#modify config with default settings
				_.extend config,
					dontCollect: yes
					params: angular.copy _.extend config.params or {},
						ks: kmc.vars.ks
						service: 'report'
						'reportInputFilter:timeZoneOffset': (new Date).getTimezoneOffset()
						'reportInputFilter:objectType': 'KalturaReportInputFilter'						


				_.extend @, (new Collection Restangular.one(''), config),
					extract:
						dict: (response) ->
							keys = response.header.split ','
							values = response.data.split ','
							_.zipObject keys, values

						graph: (response) ->
							keys = _.pluck response.item, 'id'
							values = _.pluck(response.item, 'data').map (data) ->
								for day in data.split ';' when day.length
									parts = day.split ','
									date: Date.fromn parseInt parts[0]
									value: parts[1]
							_.zipObject keys, values

						months: (response, payload, fields) =>
							parsed = @extract.graph response
							months = {}
							fields = [fields] unless _.isArray fields
							parsed_objects = {}
							for field in fields
								parsed_objects[field] = utils.arrToObjByFn parsed[field] or [], (day) -> day.date.toYMD()
							date = Date.fromYMDn payload['reportInputFilter:fromDay']
							while date.toYMDn() <= payload['reportInputFilter:toDay']
								monthMark = date.toYM()
								unless months[monthMark]?
									months[monthMark] =
										label: $filter('date') date, 'MMMM, yyyy'
										dates: []
									for field in fields
										months[monthMark][field] = 0
								months[monthMark].dates.push new Date date
								for field in fields
									months[monthMark][field] += parseFloat parsed_objects[field][date.toYMD()]?.value or 0
								date.setDate date.getDate() + 1
							for k, month of months
								for field in fields when month[field].isFloat()
									month[field] = Number.round month[field], 2
							utils.objToArr months


				#parse xml in response
				@addFetchInterceptor (response) ->
					x2js.xml_str2json(response).xml.result

				#affect global loading flag on fetching
				@extendFetch
					b: -> go.inc()
					f: -> go.dec()

				@
	]