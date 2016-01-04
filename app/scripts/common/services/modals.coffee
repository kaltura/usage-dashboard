do ->

	module = angular.module 'KalturaUsageDashboard.services.modals', [
		'classy'
		'KalturaUsageDashboard.services.modals.info'
	]

	module.service 'modals', [
		'InfoModal'
		'ConfirmModal'
		'ErrorModal'
		'WarningModal'
		'SuccessModal'
		(InfoModal, ConfirmModal, ErrorModal, WarningModal, SuccessModal) ->
			info: new InfoModal
			confirm: new ConfirmModal
			error: new ErrorModal
			warning: new WarningModal
			success: new SuccessModal
	]


	module.classy.controller
		name: 'ModalCtrl'
		injectToScope: ['data']