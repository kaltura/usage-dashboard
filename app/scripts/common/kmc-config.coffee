do ->

	module = angular.module 'KalturaUsageDashboard.kmc-config', []

	module.provider 'kmc', ->
		$get: ->
			window.kmc or vars:
				service_url: 'http://www.kaltura.com'
				ks: 'MjcxNDI5MjFjM2M0YjY5ZWUxYjQxMmYzZTRhMThhM2NkNWZjZmU4OHw5MzkzNDE7OTM5MzQxOzE0NDYwMjA3NjM7MjsxNDQ1OTM0MzYzLjgyNzQ7cmtzaGFyZWRib3hAZ21haWwuY29tO2Rpc2FibGVlbnRpdGxlbWVudDs7'