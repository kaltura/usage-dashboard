do ->

	module = angular.module 'KalturaUsageDashboard.services.modals.warning', []

	module.factory 'WarningModal', [
		'InfoModal'
		(InfoModal) ->
			class WarningModal extends InfoModal

				open: (data) =>
					@super().open _.defaults data,
						title: 'Warning'
						cancelText: null
						type: 'warning'
	]