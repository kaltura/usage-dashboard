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
				_.defaults config,
					dontCollect: yes
					params: {}
				_.defaults config.params,
					ks: kmc.vars.ks
					service: 'report'
					'reportInputFilter:timeZoneOffset': (new Date).getTimezoneOffset()
					'reportInputFilter:objectType': 'KalturaReportInputFilter'


				_.extend @, (new Collection Restangular.one(''), config),
					modifiers: (fields) ->
						fields = [fields] unless _.isArray fields
						_.extend @,
							extract:
								dict: (response={}) ->
									keys = response.header?.split ','
									lines = _.compact response.data?.split ';'
									values = _.unzip (for line in lines
										line.split ','
									)
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

								monthsComprehensive: (response, payload) =>
									dict = @extract.dict response
									result = []
									for index in [0..dict.month_id.length-1]
										result[index] = {}
										for key, values of dict
											result[index][key] = values[index]

									from = payload['reportInputFilter:fromDay']
									to = payload['reportInputFilter:toDay']
									@convert.parseFloat @convert.monthsLabelsComprehensive result,
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

								monthsLabelsComprehensive: (months, dates) ->
									fromYMn = dates.from.toYMn()
									toYMn = dates.to.toYMn()
									for month in months
										monthDateYMn = parseInt month.month_id
										monthDate = Date.fromYMn monthDateYMn
										firstDate = if monthDateYMn is fromYMn
											dates.from.getDate()
										else
											1
										lastDate = if monthDateYMn is toYMn
											dates.to.getDate()
										else
											monthDate.nDaysInMonth()

										month.label = $filter('date') monthDate, 'MMMM, yyyy'
										if firstDate isnt 1 or lastDate isnt monthDate.nDaysInMonth()
											month.label = "#{firstDate}#{if firstDate isnt lastDate then '-' + lastDate else ''} #{month.label}"
									months

								parseFloat: (months) ->
									for month in months
										for key, value of month when key isnt 'label'
											month[key] = parseFloat(value) or 0
									months

								sum: (months, field) ->
									sum = 0
									for month in months
										sum += parseFloat(month[field]) or 0
									sum

								pick: (months, field) ->
									for month in months
										item = _.pick month, 'label', field
										item[field] = parseFloat(item[field]) or 0
										item



				#parse xml in response
				@addFetchInterceptor (response) ->
					x2js.xml_str2json(response).xml.result

				#errors handling
				@addFetchInterceptor (parsed, payload) =>
					if parsed.error?
						@cancelAllRequests parsed
						errorsHandler parsed
						{}
					else
						parsed

				@extendFetch
					#affect global loading flag on fetching
					b: -> go.inc()
					f: -> go.dec()
					#errors handling
					e: errorsHandler

				@
	]