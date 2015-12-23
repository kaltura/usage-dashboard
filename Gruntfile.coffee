module.exports = (grunt) ->

	require('load-grunt-tasks') grunt
	modrewrite = require 'connect-modrewrite'
	serveStatic = require 'serve-static'
	config = require './build_config'

	grunt.initConfig
		bower: grunt.file.readJSON 'bower.json'
		config: config
		targets:
			dev: 'development'
			dist: 'production'
		ports:
			dev: 9000
			dist: 9000


		connect:
			development:
				options:
					port: '<%= ports.dev %>'
					middleware: (connect, options) ->
						[
							modrewrite [ '!(\\..+)$ /index.html [L]' ]
							serveStatic '.'
						]
			production:
				options:
					base: '<%= config.dist %>'
					port: '<%= ports.dist %>'
					middleware: (connect, options) ->
						[
							modrewrite [ '!(\\..+)$ /index.html [L]' ]
							serveStatic options.base.toString()
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
			app:
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

		includeSource:
			options:
				basePath: __dirname
			development:
				files:
					'index.html': '<%= config.app %>/index.html'
			production:
				options:
					rename: (dest, matchedSrcPath, options) ->
						re = new RegExp "^#{config.dist}\/"
						matchedSrcPath.replace re, ''
				files:
					'<%= config.dist %>/index.html': '<%= config.app %>/index.html'

		clean:
			build: ['<%= config.js_build %>']
			dist: ['<%= config.dist %>']
			protractor_specs: ['<%= config.protractor_build %>']

		concat:
			production:
				src: config.js_files
				dest: config.js_concat

		uglify:
			production:
				files:
					'<%= config.dist_scripts %>/<%= bower.name %>.min.js': [
						config.js_concat
					]

		cssmin:
			production:
				files:
					'<%= config.dist_styles %>/<%= bower.name %>.min.css': config.css_files.app

		copy:
			production:
				files: [
					expand: yes
					cwd: '<%= bower.directory %>'
					src: config.bower_files
					dest: '<%= config.dist %>/<%= bower.directory %>'
				]

		ngtemplates:
			app:
				options:
					module: 'KalturaUsageDashboard'
				src: '<%= config.scripts %>/**/*.html'
				dest: config.js_templates

		compress:
			production:
				options:
					archive: '<%= config.packages %>/<%= bower.version %>.zip'
				files: [
					expand: yes
					cwd: '<%= config.dist %>'
					src: ['**']
					dest: '<%= bower.name %>'
				]

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

	grunt.registerTask 'build', (target = grunt.config('targets').dev) ->
		targets = grunt.config 'targets'
		switch target
			when targets.dev
				grunt.config 'included_js_files', config.js_files
				grunt.config 'included_css_files', config.css_files.app
			when targets.dist
				grunt.config 'included_js_files', '<%= config.dist_scripts %>/<%= bower.name %>.min.js'
				grunt.config 'included_css_files', '<%= config.dist_styles %>/<%= bower.name %>.min.css'

		tasks = [
			'clean:dist'
			'clean:build'
			'coffee:app'
			'ngtemplates:app'
		]
		if grunt.config('concat')[target]?
			tasks.push "concat:#{target}"
		if grunt.config('uglify')[target]?
			tasks.push "uglify:#{target}"
		tasks = tasks.concat [
			'less'
		]
		if grunt.config('cssmin')[target]?
			tasks.push "cssmin:#{target}"
		if grunt.config('includeSource')[target]?
			tasks.push "includeSource:#{target}"
		if grunt.config('copy')[target]?
			tasks.push "copy:#{target}"

		#create zip
		if grunt.config('compress')[target]?
			tasks.push "compress:#{target}"

		grunt.task.run tasks

	grunt.registerTask 'serve', (target=grunt.config('targets').dev) ->
		grunt.config 'config.target', target
		grunt.task.run [
			"build:#{target}"
			"connect:#{target}"
			'watch'
		]

	grunt.registerTask 'test', ['karma', 'watch:tests']

	grunt.registerTask 'e2e', (target=grunt.config('targets').dev, ks) ->
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