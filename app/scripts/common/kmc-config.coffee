do ->

	module = angular.module 'KalturaUsageDashboard.kmc-config', []

	module.provider 'kmc', ->
		$get: ->
			ks = 'ZWQ5MWRkNmU3Zjc2YzA5Y2I5ZDVjNTdkNzhkY2E4YjIxY2JmOTkyN3w5MzkzNDE7OTM5MzQxOzE0NDYwNDQwNzI7MjsxNDQ1OTU3NjcyLjU1Njtya3NoYXJlZGJveEBnbWFpbC5jb207ZGlzYWJsZWVudGl0bGVtZW50Ozs='
			for param in (location.search or location.hash)?.split('?')[1]?.split('&') or []
				parts = param.split '='
				if parts[0] is 'ks'
					ks = parts[1]
					break
			window.kmc or vars:
				service_url: 'http://www.kaltura.com'
				ks: ks