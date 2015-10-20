do ->

	module = angular.module 'KalturaUsageDashboard.config', []


	module.config ($urlRouterProvider, $locationProvider, $httpProvider, RestangularProvider) ->
		
		$locationProvider.html5Mode yes
		$locationProvider.hashPrefix '!'

		# $httpProvider.defaults.useXDomain = yes
		# $httpProvider.interceptors.push 'authHttpResponseInterceptor'
		# delete $httpProvider.defaults.headers.common['X-Requested-With']
		# $httpProvider.defaults.withCredentials = yes

		####### FOR LOCAL DEVELOPMENT ################
		kmc =
			vars:
				service_url: 'http://www.kaltura.com'

		RestangularProvider.setBaseUrl "#{kmc.vars.service_url}/api_v3/index.php"

		$urlRouterProvider.when '/usage-dashboard', '/usage-dashboard/overall-usage'
		$urlRouterProvider.otherwise '/usage-dashboard'