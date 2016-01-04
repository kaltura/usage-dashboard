fs = require 'fs'
path = require 'path'

module.exports = class Replace
	constructor: (fileName, staticRoot, @relative) ->
		@fileName = path.resolve fileName
		@staticRoot = path.resolve staticRoot

	run: =>
		fileName = @fileName
		staticRoot = @staticRoot
		if fs.existsSync fileName
			data = fs.readFileSync(fileName).toString()
			if data and staticRoot
				return data.replace /url\s*\(\s*(['"]?)([^"'\)]*)\1\s*\)/gi, (match, location) =>
					dirName = path.resolve(path.dirname(fileName))
					url = undefined
					urlPath = undefined
					match = match.replace(/\s/g, '')
					url = match.slice(4, -1).replace(/"|'/g, '').replace(/\\/g, '/')
					if /^\/|https:|http:|data:/i.test(url) is false and dirName.indexOf(staticRoot) > -1
						urlPath = path.resolve "#{dirName}/#{url}"
						if urlPath.indexOf(staticRoot) > -1
							url = urlPath.substr(urlPath.indexOf(staticRoot) + staticRoot.length).replace(/\\/g, '/')
					if @relative
						if url[0] is '/'
							url = url.replace /^\//, ''
					"url(\"#{url}\")"
			return data
		''