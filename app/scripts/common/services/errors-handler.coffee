do ->

	module = angular.module 'KalturaUsageDashboard.services.errors-handler', []

	module.service 'errorsHandler', [
		'modals'
		(modals) ->
			(error) ->
				message = if error?.error?.code?
					switch error.error.code
						when 'INVALID_KS' then "Your session has expired. Please refresh the page to continue."
						else error.error.message
				else "Unable to load the requested information"

				modals.error.open message: message
	]