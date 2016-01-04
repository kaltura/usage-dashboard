module.exports = (grunt) ->

	require('load-grunt-tasks') grunt
	modrewrite = require 'connect-modrewrite'
	serveStatic = require 'serve-static'
	config = require './build_config'

	grunt.loadTasks 'grunt_tasks/cssUrlReplace/tasks'

	grunt.initConfig
		bower: grunt.file.readJSON 'bower.json'
		config: config


		connect:
			development:
				options:
					port: '<%= config.ports.dev %>'
					middleware: (connect, options) ->
						[
							modrewrite [ '!(\\..+)$ /index.html [L]' ]
							serveStatic '.'
						]
			production:
				options:
					base: '<%= config.dist %>'
					port: '<%= config.ports.dist %>'
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

			production: ['<%= config.css_url_replace %>']

		concat:
			production:
				src: config.js_files
				dest: config.js_concat

		uglify:
			production:
				files:
					'<%= config.dist_scripts %>': [
						config.js_concat
					]

		cssUrlReplace:
			production:
				options:
					staticRoot: __dirname
					relative: yes
				files:
					'<%= config.css_url_replace %>': config.css_files

		cssmin:
			production:
				files:
					'<%= config.dist_styles %>': config.css_url_replace

		processhtml:
			development:
				options:
					data:
						base: '<%= config.bases[config.target] %>'
				files:
					'index.html': ['index.html']
			production:
				options:
					data:
						base: '<%= config.bases[config.target] %>'
				files:
					'<%= config.dist %>/index.html': ['<%= config.dist %>/index.html']

		copy:
			production:
				files: [
					expand: yes
					cwd: '.'
					src: config.bower_files
					dest: '<%= config.dist %>'
				,
					expand: yes
					cwd: '.'
					src: config.image_files
					dest: '<%= config.dist %>'
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
					archive: '<%= config.packages %>/kaltura-usage-dashboard-v<%= bower.version %>.zip'
				files: [
					expand: yes
					cwd: '<%= config.dist %>'
					src: ['**']
					dest: 'v<%= bower.version %>'
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

	grunt.registerTask 'build', (target = grunt.config('config.targets').dev) ->
		grunt.config 'config.target', target
		targets = grunt.config 'config.targets'
		switch target
			when targets.dev
				grunt.config 'included_js_files', config.js_files
				grunt.config 'included_css_files', config.css_files
			when targets.dist
				grunt.config 'included_js_files', '<%= config.dist_scripts %>'
				grunt.config 'included_css_files', '<%= config.dist_styles %>'

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
		if grunt.config('cssUrlReplace')[target]?
			tasks.push "cssUrlReplace:#{target}"
		if grunt.config('cssmin')[target]?
			tasks.push "cssmin:#{target}"
		if grunt.config('clean')[target]?
			tasks.push "clean:#{target}"
		if grunt.config('includeSource')[target]?
			tasks.push "includeSource:#{target}"
		if grunt.config('processhtml')[target]?
			isServing = grunt.config('config').isServing
			grunt.log.writeln isServing
			if isServing
				grunt.config.set "processhtml.#{target}.options.data.base", config.bases[targets.dev]
				grunt.log.writeln grunt.config 'processhtml[<%= config.target %>].options.data.base'
			tasks.push "processhtml:#{target}"
		if grunt.config('copy')[target]?
			tasks.push "copy:#{target}"

		#create zip
		if grunt.config('compress')[target]?
			tasks.push "compress:#{target}"

		grunt.task.run tasks

	grunt.registerTask 'serve', (target=grunt.config('config.targets').dev) ->
		grunt.config 'config.isServing', yes
		grunt.task.run [
			"build:#{target}"
			"connect:#{target}"
			'watch'
		]

	grunt.registerTask 'test', ['karma', 'watch:tests']

	grunt.registerTask 'e2e', (target=grunt.config('config.targets').dev, ks) ->
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