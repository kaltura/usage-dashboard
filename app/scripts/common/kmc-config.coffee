do ->

	module = angular.module 'KalturaUsageDashboard.kmc-config', []

	module.provider 'kmc', ->
		$get: ->
			window.kmc or vars:
				service_url: 'http://www.kaltura.com'
				ks: 'Y2M0MDY1ZWU5ZTk2NThhMjJlMzgyMzM2MzUwYzVjMTUyNmZjZmY3MHw5MzkzNDE7OTM5MzQxOzE0NDU2MDUyOTM7MjsxNDQ1NTE4ODkzLjMxMzg7cmtzaGFyZWRib3hAZ21haWwuY29tO2Rpc2FibGVlbnRpdGxlbWVudDs7'