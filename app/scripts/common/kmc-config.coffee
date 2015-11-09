do ->

	module = angular.module 'KalturaUsageDashboard.kmc-config', []

	module.provider 'kmc', ->
		$get: ->
			ks = 'NWRmM2M0NzQ5Njc3OGE4MDY0NzczMGU4OTIzOWZiNGZlNjg5ODdhY3w5MzkzNDE7OTM5MzQxOzE0NDY4MzY5NjM7MjsxNDQ2NzUwNTYzLjM1OTc7cmtzaGFyZWRib3hAZ21haWwuY29tO2Rpc2FibGVlbnRpdGxlbWVudDs7'
			for param in (location.search or location.hash)?.split('?')[1]?.split('&') or []
				parts = param.split '='
				if parts[0] is 'ks'
					ks = parts[1]
					break
			window.kmc or vars:
				service_url: 'http://www.kaltura.com'
				ks: ks