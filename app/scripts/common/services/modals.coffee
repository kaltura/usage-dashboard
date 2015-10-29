do ->

	module = angular.module 'KalturaUsageDashboard.services.modals', [
		'classy'
		'KalturaUsageDashboard.services.modals.info'
	]

	module.service 'modals', [
		'ConfirmModal'
		'ErrorModal'
		(ConfirmModal, ErrorModal) ->
			confirm: new ConfirmModal
			error: new ErrorModal
	]


	module.classy.controller
		name: 'ModalCtrl'
		injectToScope: ['data']