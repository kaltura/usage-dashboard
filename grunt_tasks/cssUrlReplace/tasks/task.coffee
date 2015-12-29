Replace = require '../replace'

module.exports = (grunt) ->
	grunt.registerMultiTask 'cssUrlReplace', ->
		# Merge task-specific and/or target-specific options with these defaults.
		options = @options
			staticRoot: 'public'
			relative: no
		# Iterate over all specified file groups.
		@files.forEach (f) ->
			# Concat specified files.
			src = f.src.filter((filepath) ->
				# Warn on and remove invalid source files (if nonull was set).
				unless grunt.file.exists(filepath)
					grunt.log.warn 'Source file "' + filepath + '" not found.'
					no
				else
					yes
			).map((filepath) ->
				# Read file source and replace relative url with absolute ones.
				new Replace(filepath, options.staticRoot, options.relative).run()
			).join('\n')
			# Write the destination file.
			grunt.file.write f.dest, src
			# Print a success message.
			grunt.log.writeln 'File "' + f.dest + '" created.'