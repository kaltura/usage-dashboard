do ->

	module = angular.module 'KalturaUsageDashboard.services.modals', ['classy']

	module.service 'modals', [
		'$uibModal'
		($uibModal) ->
			_.extend @,

				info: (data) ->
					$uibModal.open
						templateUrl: 'app/scripts/common/modals/info-modal.html'
						controller: 'ModalCtrl'
						resolve:
							data: -> data


				confirm: (data) =>
					data.title = 'Confirmation' unless data.title?
					data.okText = 'OK' unless data.okText
					data.cancelText = 'Cancel' unless data.cancelText
					data.type = 'confirm'
					@info data

				error: (data) ->
					data.title = 'Error' unless data.title?
					data.okText = 'OK' unless data.cancelText
					data.type = 'error'
					@info data
	]

	module.classy.controller
		name: 'ModalCtrl'
		injectToScope: ['data']