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
			pages: '<%= config.scripts %>/pages'
			common: '<%= config.scripts %>/common'
			js_build: '<%= config.scripts %>/build'

		connect:
			app:
				options:
					port: 9000
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

		uglify:
			production:
				files:
					'<%= config.js_build %>/<%= bower.name %>.js': ['<%= config.js_build %>/<%= bower.name %>.js']

	# allowed 'development' or 'production'
	grunt.registerTask 'build', (target='development') ->
		tasks = [
			'clean:build'
			"coffee:#{target}"
		]
		switch target
			when 'production'
				tasks.push 'uglify'
		tasks = tasks.concat [
			'less'
			'includeSource'
			'wiredep'
		]
		grunt.task.run tasks

	grunt.registerTask 'serve', (target='development') ->
		grunt.config 'config.target', target
		grunt.task.run [
			"build:#{target}"
			'connect'
			'watch'
		]

	grunt.registerTask 'default', ['serve']