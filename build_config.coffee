module.exports =
	dist: 'dist'
	dist_styles: '<%= config.dist %>/styles'
	dist_scripts: '<%= config.dist %>/scripts'
	dist_images: '<%= config.dist %>/images'
	packages: 'packages'
	app: 'app'
	assets: '<%= config.app %>/assets'
	shims: '<%= config.app %>/shims'
	styles: '<%= config.app %>/styles'
	less: '<%= config.styles %>/less'
	scripts: '<%= config.app %>/scripts'
	tests: '<%= config.app %>/tests'
	protractor: '<%= config.tests %>/protractor'
	protractor_build: '<%= config.protractor %>/specs'
	pages: '<%= config.scripts %>/pages'
	common: '<%= config.scripts %>/common'
	js_build: '<%= config.scripts %>/build'
	js_templates: '<%= config.js_build %>/templates.js'
	js_concat: '<%= config.js_build %>/all_concatenated.js'

	bower_files: [
		'**/*.css'

		'**/*.png'
		'**/*.jpg'
		'**/*.jpeg'
		'**/*.ico'
		'**/*.gif'

		'**/*.eot'
		'**/*.svg'
		'**/*.ttf'
		'**/*.woff'
		'**/*.woff2'
		'**/*.otf'
	]

	css_files:
		bower: [
			'<%= bower.directory %>/jquery-ui/themes/smoothness/jquery-ui.css'
			'<%= bower.directory %>/jquery-ui-bootstrap/jquery.ui.theme.css'
			'<%= bower.directory %>/font-awesome/css/font-awesome.css'
			'<%= bower.directory %>/select2/select2.css'
			'<%= bower.directory %>/angular-spinkit/build/angular-spinkit.min.css'
			'<%= bower.directory %>/bootstrap/dist/css/bootstrap.min.css'
		]
		app: [
			'<%= config.styles %>/<%= bower.name %>.css'
		]

	js_files: [
		'<%= config.shims %>/**/*.js'

		'<%= bower.directory %>/jquery/dist/jquery.js'
		'<%= bower.directory %>/ExplorerCanvas/excanvas.js'
		'<%= bower.directory %>/html5shiv/dist/html5shiv.js'
		'<%= bower.directory %>/augment/augment.js'
		'<%= bower.directory %>/bootstrap/dist/js/bootstrap.js'
		'<%= bower.directory %>/select2/select2.js'
		'<%= bower.directory %>/jquery-flot/jquery.flot.js'
		'<%= bower.directory %>/angular/angular.js'
		'<%= bower.directory %>/lodash/lodash.js'
		'<%= bower.directory %>/restangular/dist/restangular.min.js'
		'<%= bower.directory %>/angular-flot/angular-flot.js'
		'<%= bower.directory %>/jquery-ui/jquery-ui.js'
		'<%= bower.directory %>/angular-ui-date/src/date.js'
		'<%= bower.directory %>/flot.tooltip/js/jquery.flot.tooltip.js'
		'<%= bower.directory %>/angular-select2-ie/dist/angular-select2.js'
		'<%= bower.directory %>/angular-bootstrap/ui-bootstrap-tpls.js'
		'<%= bower.directory %>/angular-ui-router/release/angular-ui-router.js'
		'<%= bower.directory %>/ng-bundle-collection/dist/ng-bundle-collection.js'
		'<%= bower.directory %>/x2js/xml2json.min.js'
		'<%= bower.directory %>/angular-x2js/dist/x2js.min.js'
		'<%= bower.directory %>/angular-spinkit/build/angular-spinkit.js'
		'<%= bower.directory %>/angular-sanitize/angular-sanitize.js'
		'<%= bower.directory %>/ng-csv/build/ng-csv.min.js'
		'<%= bower.directory %>/flot-axislabels/jquery.flot.axislabels.js'

		'<%= config.assets %>/**/*.js'

		'<%= config.js_build %>/**/*.js'
	]