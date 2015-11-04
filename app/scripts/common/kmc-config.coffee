do ->

	module = angular.module 'KalturaUsageDashboard.kmc-config', []

	module.provider 'kmc', ->
		$get: ->
			ks = 'MzE2ZWQzMjJkYmE1MjQyNmM5ZjA2YjY0YjUyYWU5NGFiZDBkYTIxMHw5MzkzNDE7OTM5MzQxOzE0NDY3NDg2MjQ7MjsxNDQ2NjYyMjI0LjUyNDg7cmtzaGFyZWRib3hAZ21haWwuY29tO2Rpc2FibGVlbnRpdGxlbWVudDs7'
			for param in (location.search or location.hash)?.split('?')[1]?.split('&') or []
				parts = param.split '='
				if parts[0] is 'ks'
					ks = parts[1]
					break
			window.kmc or vars:
				service_url: 'http://www.kaltura.com'
				ks: ks