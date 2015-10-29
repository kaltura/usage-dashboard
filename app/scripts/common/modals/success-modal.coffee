do ->

	module = angular.module 'KalturaUsageDashboard.services.modals.success', []

	module.factory 'SuccessModal', [		
		'InfoModal'
		(InfoModal) ->
			class SuccessModal extends InfoModal

				open: (data) =>
					@super().open _.defaults data,
						title: 'Success'
						cancelText: null
						type: 'success'
	]