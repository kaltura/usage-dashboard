do ->

	module = angular.module 'KalturaUsageDashboard.rest.vpaas-usage-report', []


	module.service 'vpaasUsageReport', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getTable'
					reportType: 26
					'pager:objectType': 'KalturaFilterPager'
					'pager:pageIndex': 1
					'pager:pageSize': 1


			modifiers = @modifiers()

			@addFetchInterceptor (response, payload) ->
				if _.isObject response
					modifiers.extract.monthsComprehensive response, payload
				else
					response


			_.extend @,
				plays:
					number: =>
						@fetch(arguments...).then (response) =>
							modifiers.convert.sum response, 'total_plays'

					mediaEntriesNumber: =>
						@fetch(arguments...).then (response) =>
							modifiers.convert.sum response, 'total_media_entries'

					data: =>
						@fetch(arguments...).then (response) =>
							modifiers.convert.pick response, 'total_plays'

				storage: =>
					@fetch(arguments...).then (response) =>
						modifiers.convert.pick response, 'avg_storage_gb'

				bandwidth: =>
					@fetch(arguments...).then (response) =>
						modifiers.convert.pick response, 'bandwidth_gb'

				transcoding: =>
					@fetch(arguments...).then (response) =>
						modifiers.convert.pick response, 'transcoding_gb'

				media: =>
					@fetch(arguments...).then (response) =>
						modifiers.convert.pick response, 'total_media_entries'

				users: =>
					@fetch(arguments...).then (response) =>
						modifiers.convert.pick response, 'total_end_users'


	]