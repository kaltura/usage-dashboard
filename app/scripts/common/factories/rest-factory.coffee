do ->

	module = angular.module 'KalturaUsageDashboard.factories.rest', []

	module.factory 'RestFactory', [
		'Restangular'
		'Collection'
		'x2js'
		'go'
		'kmc'
		'utils'
		(Restangular, Collection, x2js, go, kmc, utils) ->
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
									date: utils.date.fromYMDn parseInt parts[0]
									value: parts[1]
							_.zipObject keys, values


				#parse xml in response
				@addFetchInterceptor (response) ->
					x2js.xml_str2json(response).xml.result

				#affect global loading flag on fetching
				@extendFetch
					b: -> go.inc()
					f: -> go.dec()

				@
	]