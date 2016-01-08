do ->

	module = angular.module 'KalturaUsageDashboard.services.errors-handler', []

	module.service 'errorsHandler', [
		'modals'
		(modals) ->
			(error) ->
				error = error?.error or error
				message = if error?.code?
					switch error.code
						when 'INVALID_KS' then "Your session has expired. Please refresh the page to continue."
						else error.message
				else "Unable to load the requested information"

				modals.error.open message: message
	]