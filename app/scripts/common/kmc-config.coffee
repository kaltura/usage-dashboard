do ->

	module = angular.module 'KalturaUsageDashboard.kmc-config', []

	module.provider 'kmc', ->
		$get: ->
			ks = 'NzYxMzJjODgyMzA4NGU5YWExODRmY2E5NmZmNDcxOGQ0NTU2ZTk5ZXw5MzkzNDE7OTM5MzQxOzE0NDcxODU0MjQ7MjsxNDQ3MDk5MDI0LjM1Njg7cmtzaGFyZWRib3hAZ21haWwuY29tO2Rpc2FibGVlbnRpdGxlbWVudDs7'
			for param in (location.search or location.hash)?.split('?')[1]?.split('&') or []
				parts = param.split '='
				if parts[0] is 'ks'
					ks = parts[1]
					break
			window.kmc or vars:
				service_url: 'http://www.kaltura.com'
				ks: ks