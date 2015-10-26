do ->

	module = angular.module 'KalturaUsageDashboard.factories.module-consolidator', []

	module.factory 'ModuleConsolidator', ->
		(module, trim = '', serviceName = _.last module.name.split '.') ->
			data = {}
			injector = angular.injector [
				'ng'
				'KalturaUsageDashboard'
				($provide) ->
					$provide.value '$rootElement', angular.element window.document
					undefined
			]
			for f in module._invokeQueue
				name = f[2][0]
				data[name.replace trim, ''] = injector.get name unless name is serviceName
			data
