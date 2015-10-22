do ->

	module = angular.module 'KalturaUsageDashboard.rest', [
		'KalturaUsageDashboard.rest.plays-report'
		'KalturaUsageDashboard.rest.bandwidth-report'
		'KalturaUsageDashboard.rest.storage-report'
		'KalturaUsageDashboard.rest.transcoding-consumption-report'
		'KalturaUsageDashboard.rest.media-entries-report'
	]