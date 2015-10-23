do ->

	module = angular.module 'KalturaUsageDashboard.kmc-config', []

	module.provider 'kmc', ->
		$get: ->
			window.kmc or vars:
				service_url: 'http://www.kaltura.com'
				ks: 'MDlmMDlmYmQzZGMwMWYwNTEzOWEwNWUyNTA1ODY4ZDJiODU0ZjRjMnw5MzkzNDE7OTM5MzQxOzE0NDU2OTI0Nzg7MjsxNDQ1NjA2MDc4LjkzMzU7cmtzaGFyZWRib3hAZ21haWwuY29tO2Rpc2FibGVlbnRpdGxlbWVudDs7'