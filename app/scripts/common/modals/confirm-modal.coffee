do ->

	module = angular.module 'KalturaUsageDashboard.services.modals.confirm', []

	module.factory 'ConfirmModal', [
		'InfoModal'
		(InfoModal) ->
			class ConfirmModal extends InfoModal

				open: (data) =>
					@super().open _.defaults data,
						title: 'Confirmation'
						type: 'confirm'
	]