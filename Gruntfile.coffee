module.exports = (grunt) ->

	require('load-grunt-tasks') grunt
	modrewrite = require 'connect-modrewrite'
	serveStatic = require 'serve-static'

	grunt.initConfig
		config:
			app: 'app'
			assets: '<%= config.app %>/assets'
			styles: '<%= config.app %>/styles'
			less: '<%= config.styles %>/less'
			scripts: '<%= config.app %>/scripts'
			pages: '<%= config.scripts %>/pages'
			common: '<%= config.scripts %>/common'

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
				tasks: 'less:app'
			coffee:
				files: '<%= config.scripts %>/**/*.coffee'
				tasks: 'coffee:app'
			index:
				files: ['bower.json', 'index.html']
				tasks: 'wiredep'
			gruntfile:
				files: 'Gruntfile.coffee'
				tasks: 'build'

		coffee:
			app:
				options:
					bare: yes
				files:
					'<%= config.scripts %>/kaltura-usage-dashboard.js': [
						'<%= config.common %>/**/*.coffee'
						'<%= config.pages %>/**/*.coffee'
						'<%= config.scripts %>/*.coffee'
					]

		less:
			app:
				files:
					'<%= config.styles %>/kaltura-usage-dashboard.css': '<%= config.less %>/main.less'

		wiredep:
			index:
				src: ['index.html']
				options:
					devDependencies: yes

	grunt.registerTask 'build', [
		'coffee'
		'less'
		'wiredep'
	]

	grunt.registerTask 'serve', [
		'build'
		'connect'
		'watch'
	]

	grunt.registerTask 'default', ['serve']