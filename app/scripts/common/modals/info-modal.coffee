do ->

	module = angular.module 'KalturaUsageDashboard.services.modals.info', [
		'KalturaUsageDashboard.services.modals.confirm'
		'KalturaUsageDashboard.services.modals.error'
		'KalturaUsageDashboard.services.modals.warning'
		'KalturaUsageDashboard.services.modals.success'
	]

	module.factory 'InfoModal', [
		'Modal'
		(Modal) ->
			class InfoModal extends Modal

				params:
					templateUrl: 'app/scripts/common/modals/info-modal.html'
					controller: 'ModalCtrl'

				open: (data) =>
					@super().open _.defaults(data,
						okText: 'OK'
						cancelText: 'Cancel'
						type: 'info'
					), @params
	]