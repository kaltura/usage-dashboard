do ->

	module = angular.module 'KalturaUsageDashboard.kmc-config', []

	module.provider 'kmc', ->
		$get: ->
			ks = 'Yzg5MDFjMmM1M2RlNGZhOWUwOTczNjg4OGFiMDAxY2EwNzFlYjk4OXw5MzkzNDE7OTM5MzQxOzE0NDYyMjc4MDU7MjsxNDQ2MTQxNDA1LjE5ODU7cmtzaGFyZWRib3hAZ21haWwuY29tO2Rpc2FibGVlbnRpdGxlbWVudDs7'
			for param in (location.search or location.hash)?.split('?')[1]?.split('&') or []
				parts = param.split '='
				if parts[0] is 'ks'
					ks = parts[1]
					break
			window.kmc or vars:
				service_url: 'http://www.kaltura.com'
				ks: ks