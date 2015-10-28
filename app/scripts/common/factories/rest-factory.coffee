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
		'errorsHandler'
		(Restangular, Collection, x2js, go, kmc, utils, $filter, errorsHandler) ->
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
					modifiers: (fields) ->
						fields = [fields] unless _.isArray fields
						_.extend @,
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

								months: (response, payload) =>
									parsed = @extract.graph response
									parsed_objects = {}
									for field in fields
										parsed_objects[field] = utils.arrToObjByFn parsed[field] or [], (day) -> day.date.toYMD()
									months = {}
									from = payload['reportInputFilter:fromDay']
									to = payload['reportInputFilter:toDay']
									date = Date.fromYMDn from
									while date.toYMDn() <= to
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
									@convert.monthsLabels utils.objToArr(months),
										from: Date.fromYMDn from
										to: Date.fromYMDn to

							convert:
								MBtoGB: (months) ->
									for month in months
										for field in fields
											month[field] /= 1024
									months

								monthsLabels: (months, dates) ->
									for month in months
										monthDate = new Date month.dates[0]
										if month.dates.length isnt monthDate.nDaysInMonth() and monthDate.toYMn() in [dates.from.toYMn(), dates.to.toYMn()]
											firstDate = monthDate.getDate()
											lastDate = month.dates[month.dates.length-1].getDate()
											month.label = "#{firstDate}#{if firstDate isnt lastDate then '-' + lastDate else ''} #{month.label}"
									months



				#parse xml in response
				@addFetchInterceptor (response) ->
					x2js.xml_str2json(response).xml.result

				#errors handling
				@addFetchInterceptor (parsed, payload) =>
					if parsed.error?
						@cancelAllRequests parsed
						{}
					else
						parsed

				#affect global loading flag on fetching
				@extendFetch
					b: -> go.inc()
					f: -> go.dec()
					e: errorsHandler

				@
	]