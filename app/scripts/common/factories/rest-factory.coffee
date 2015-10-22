do ->

	module = angular.module 'KalturaUsageDashboard.factories.rest', []

	module.factory 'RestFactory', (Restangular, Collection, x2js) ->
		(config) ->
			_.extend config,
				dontCollect: yes
			rest = new Collection Restangular.one(''), config
			rest.addFetchInterceptor (response) ->
					x2js.xml_str2json(response).xml.result
			rest