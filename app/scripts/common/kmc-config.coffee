do ->

	module = angular.module 'KalturaUsageDashboard.kmc-config', []

	module.provider 'kmc', ->
		$get: ->
			window.kmc or vars:
				service_url: 'http://www.kaltura.com'
				ks: 'YTQ2OGFkNDVmYzU5ZTlkMTJkZGM3YmNkMTdiMDRiNjU0ZGY0MzIzMHw5MzkzNDE7OTM5MzQxOzE0NDU1MTgzNTE7MjsxNDQ1NDMxOTUxLjkxNjtya3NoYXJlZGJveEBnbWFpbC5jb207ZGlzYWJsZWVudGl0bGVtZW50Ozs='