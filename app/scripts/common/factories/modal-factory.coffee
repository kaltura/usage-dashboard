do ->

	module = angular.module 'KalturaUsageDashboard.factories.modal', []

	module.factory 'Modal', [
		'$uibModal'
		($uibModal) ->
			class Modal extends Class
				opened: {}

				_mark: (data, params) =>
					JSON.stringify
						data: data
						params: params


				open: (data, params) =>
					_.extend params or {},
						resolve:
							data: -> data

					mark = @_mark data, params

					return if @opened[mark]

					instance = $uibModal.open params

					@opened[mark] = yes

					instance.result.finally =>
						delete @opened[mark]

					instance
	]