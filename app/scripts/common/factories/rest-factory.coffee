do ->

	module = angular.module 'KalturaUsageDashboard.factories.rest', []

	module.factory 'RestFactory', (Restangular, Collection, x2js, go) ->
		(config) ->
			_.extend config,
				dontCollect: yes

			_.extend @, (new Collection Restangular.one(''), config),
				extract:
					dict: (response) ->
						keys = response.header.split ','
						values = response.data.split ','
						_.zipObject keys, values

			@addFetchInterceptor (response) ->
				x2js.xml_str2json(response).xml.result

			@extendFetch
				b: -> go.inc()
				f: -> go.dec()

			@