module.exports = (grunt) ->

	require('load-grunt-tasks') grunt
	modrewrite = require 'connect-modrewrite'
	serveStatic = require 'serve-static'

	grunt.initConfig
		bower: grunt.file.readJSON 'bower.json'
		config:
			app: 'app'
			assets: '<%= config.app %>/assets'
			styles: '<%= config.app %>/styles'
			less: '<%= config.styles %>/less'
			scripts: '<%= config.app %>/scripts'
			tests: '<%= config.app %>/tests'
			protractor: '<%= config.tests %>/protractor'
			protractor_build: '<%= config.protractor %>/specs'
			pages: '<%= config.scripts %>/pages'
			common: '<%= config.scripts %>/common'
			js_build: '<%= config.scripts %>/build'
		targets:
			default: 'development'
			prod: 'production'
		ports:
			dev: 9000


		connect:
			app:
				options:
					port: '<%= ports.dev %>'
					middleware: (connect, options) ->
						[
							modrewrite [ '!(\\..+)$ /index.html [L]' ]
							serveStatic '.'
						]

		watch:
			less:
				files: '<%= config.styles %>/**/*.less'
				tasks: 'build:<%= config.target %>'
			coffee:
				files: '<%= config.scripts %>/**/*.coffee'
				tasks: 'build:<%= config.target %>'
			index:
				files: ['bower.json', '<%= config.app %>/index.html']
				tasks: 'build:<%= config.target %>'
			gruntfile:
				files: 'Gruntfile.coffee'
				tasks: 'build:<%= config.target %>'
			tests:
				files: '<%= config.tests %>/**/*.js'
				tasks: 'karma'

		coffee:
			options:
				bare: yes
			production:
				files:
					'<%= config.js_build %>/<%= bower.name %>.js': [
						'<%= config.common %>/**/*.coffee'
						'<%= config.pages %>/**/*.coffee'
						'<%= config.scripts %>/*.coffee'
					]
			development:
				expand: yes
				# flatten: yes
				cwd: '<%= config.scripts %>'
				src: '**/*.coffee'
				dest: '<%= config.js_build %>'
				ext: '.js'
			protractor_specs:
				files:
					'<%= config.protractor_build %>/specs.js': '<%= config.protractor %>/coffee/**/*.coffee'


		less:
			app:
				files:
					'<%= config.styles %>/<%= bower.name %>.css': '<%= config.less %>/main.less'

		wiredep:
			index:
				options:
					devDependencies: yes
				src: ['index.html']

		includeSource:
			options:
				basePath: __dirname
			index:
				files:
					'index.html': '<%= config.app %>/index.html'

		clean:
			build: ['<%= config.js_build %>']
			protractor_specs: ['<%= config.protractor_build %>']

		uglify:
			production:
				files:
					'<%= config.js_build %>/<%= bower.name %>.js': ['<%= config.js_build %>/<%= bower.name %>.js']

		karma:
			unit:
				configFile: '<%= config.tests %>/karma.config.js'
				background: yes
				singleRun: no

		protractor:
			options:
				noColor: no
			e2e:
				options:
					configFile: '<%= config.protractor %>/conf.js'
					args:
						chromeDriver: 'node_modules/grunt-webdriver-manager/bin'


		webdrivermanager:
			seleniumPort: 4444
			proxy: no

	# allowed 'development' or 'production'
	grunt.registerTask 'build', (target=grunt.config('targets').default) ->
		tasks = [
			'clean:build'
			"coffee:#{target}"
		]
		switch target
			when grunt.config('targets').prod
				tasks.push 'uglify'
		tasks = tasks.concat [
			'less'
			'includeSource'
			'wiredep'
		]
		grunt.task.run tasks

	grunt.registerTask 'serve', (target=grunt.config('targets').default) ->
		grunt.config 'config.target', target
		grunt.task.run [
			"build:#{target}"
			'connect:app'
			'watch'
		]

	grunt.registerTask 'test', ['karma', 'watch:tests']

	grunt.registerTask 'e2e', (target=grunt.config('targets').default, ks) ->
		if ks
			grunt.config 'protractor.e2e.options.args.params.ks', ks

		grunt.task.run [
			'clean:protractor_specs'
			'coffee:protractor_specs'
			"build:#{target}"
			'connect:app'
			'webdrivermanager:start'
			'protractor:e2e'
			'webdrivermanager:stop'
		]

	grunt.registerTask 'default', ['serve']