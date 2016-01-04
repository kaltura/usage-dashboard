do ->
	'use strict'
	###
	name: Angular Classy
	version: 0.4.2
	author: Dave Jeffery, @DaveJ
	additions:
		version: 1.1.1
		author: Vitaliy Tarash, @Pulse
		additions: [
			'injectToScope ability for classy controllers'
			'ability to specify common injections to controller and to scope'
			'ability to inject nested properties of initial dependencies'
			'tryApply in each controller with scope'
		]
	License: MIT
	###

	### global angular ###

	'"/../'

	defaults =
		controller:
			addFnsToScope: true
			watchObject: true
			_scopeName: '$scope'
			_scopeShortcut: true
			_scopeShortcutName: '$'
			_watchKeywords:
				objectEquality: ['{object}', '{deep}']
				collection: ['{collection}', '{shallow}']
				group: ['{group}']
			_defaultProperties: ['constructor', 'init', 'watch', 'listen']


	origMethod = angular.module
	angular.module = (name, reqs, configFn) ->
		###
		# We have to monkey-patch the `angular.module` method to see if 'classy' has been specified
		# as a requirement. We also need the module name to we can register our classy controllers.
		# Unfortunately there doesn't seem to be a more pretty/pluggable way to this.
		###
		module = origMethod(name, reqs, configFn)

		# If this module has required 'classy' then we're going to add `ClassyController`
		if reqs and 'classy' in reqs
			module.classy =
				configure: (config) -> _.extend module.classy.options, config
				options:
					controller: {}
					commonInjections: ['$scope']
					commonInjectionsToScope: []

				controller: (classObj) ->
					classObj.__options = angular.extend {}, defaults.controller, module.classy.options.controller, classObj.__options
					c = class ClassyController
						# `ClassyController` contains only a set of proxy functions for `classFns`,
						# this is because I suspect that performance is better this way.
						# TODO: Test performance to see if this is the most performant way to do it.

						__options: classObj.__options

						# Create the Classy Controller
						classFns.create(module, classObj, @)

						constructor: ->
							# Where the magic happens
							classFns.construct(@, arguments)

					for own key,value of classObj
						c::[key] = value

					return c

			module.cC = module.ClassyController = module.classy.controller


		return module

	angular.module('classy', [])


	scopeDepsObj = {}

	classFns =
		selectorControllerCount: 0

		construct: (parent, args) ->
			options = parent.constructor::__options
			@bindDependencies(parent, args)
			if options.addFnsToScope
				@addFnsToScopeAndSetWatchers parent
				@injectScopeDepsAndSetWatchers parent, scopeDepsObj[parent.name] if scopeDepsObj[parent.name]?
			
			@addTryApply parent

			parent.init?()
			@registerWatchers parent if options.watchObject and angular.isObject parent.watch
			@registerListeners parent if angular.isObject parent.listen

		addTryApply: (parent) ->
			$scope = parent[parent.constructor::__options._scopeName]
			if $scope?
				parent.tryApply = (fn) ->
					if $scope.$$phase then fn() else $scope.$apply fn

		addFnsToScopeAndSetWatchers: (parent) ->
			# Adds controller functions (unless they have a `_` prefix) to the `$scope`
			$scope = parent[parent.constructor::__options._scopeName]
			for key, fn of parent.constructor::
				continue unless angular.isFunction(fn)
				continue if key in defaults.controller._defaultProperties
				parent[key] = angular.bind(parent, fn)
				if key[0] isnt '_'
					$scope[key] = parent[key]

			# Set watchers by controller deps
			for key, prop of parent
				((key, prop) ->
					if prop?.watchItByClassy
						$scope["#{key}_fn"] = prop.fn
						$scope.$watch "#{key}_fn()", (value) -> parent[key] = value
				) key, prop


		__isCompositeDep: (key) -> key.indexOf('.') > -1

		__calcCompositeDepName: (key, deps) ->
			tokens = key.split '.'
			last = _.last tokens
			existSameLast = no
			existSameLast = yes for d in deps when _.last(d.split '.') is last and d isnt key
			if existSameLast or last in deps
				key.replace /\./g, '_'
			else
				last

		injectScopeDepsAndSetWatchers: (parent, scopeDeps) ->
			$scope = parent[parent.constructor::__options._scopeName]
			#set watchers by scopeDeps
			for key in scopeDeps
				if classFns.__isCompositeDep key
					tokens = key.split '.'
					value = parent
					for t in tokens
						value = value[t]
					name = classFns.__calcCompositeDepName key, scopeDeps
					parent[name] = value
					$scope[name] = value
				else
					if parent[key]?.watchItByClassy?
						((key) ->
							$scope["#{key}_fn"] = parent[key].fn
							$scope.$watch "#{key}_fn()", (value) -> $scope[key] = value
						) key
					else
						$scope[key] = parent[key]



		bindDependencies: (parent, args) ->
			injectObject = parent.__ClassyControllerInjectObject
			injectObjectMode = !!injectObject
			options = parent.constructor::__options

			# Takes the `$inject` dependencies and assigns a class-wide (`@`) variable to each one.
			for key, i in parent.constructor.$inject
				if injectObjectMode and (injectName = injectObject[key]) and injectName != '.'
					parent[injectName] = args[i]
				else
					parent[key] = args[i]

					if key is options._scopeName and options._scopeShortcut
						# Add a shortcut to the $scope (by default `this.$`)
						parent[options._scopeShortcutName] = parent[key]

		registerListeners: (parent) ->
			$scope = parent[parent.constructor::__options._scopeName]
			$scope.$on eventName, angular.bind parent, listener for eventName, listener of parent.listen

		registerWatchers: (parent) ->
			# Iterates over the watch object and creates the appropriate `$scope.$watch` listener
			$scope = parent[parent.constructor::__options._scopeName]

			if !$scope
				throw new Error "You need to inject `$scope` to use the watch object"

			watchKeywords = parent.constructor::__options._watchKeywords
			watchTypes =
				normal:
					keywords: []
					fnCall: (parent, expression, fn) ->
						$scope.$watch(expression, angular.bind(parent, fn))
				objectEquality:
					keywords: watchKeywords.objectEquality
					fnCall: (parent, expression, fn) ->
						$scope.$watch(expression, angular.bind(parent, fn), true)
				collection:
					keywords: watchKeywords.collection
					fnCall: (parent, expression, fn) ->
						$scope.$watchCollection(expression, angular.bind(parent, fn))
				group:
					keywords: watchKeywords.group
					fnCall: (parent, expression, fn) ->
						$scope.$watchGroup(expression.split(','), angular.bind(parent, fn))

			for expression, fn of parent.watch
				if angular.isString(fn) then fn = parent[fn]
				if angular.isString(expression) and angular.isFunction(fn)
					watchRegistered = false

					# Search for keywords that identify it is a non-standard watch
					for watchType of watchTypes
						if watchRegistered then break
						for keyword in watchTypes[watchType].keywords
							if watchRegistered then break
							if expression.indexOf(keyword) isnt -1
								watchTypes[watchType].fnCall(parent, expression.replace(keyword, ''), fn)
								watchRegistered = true

					# If no keywords have been found then register it as a normal watch
					if !watchRegistered then watchTypes.normal.fnCall(parent, expression, fn)

		inject: (parent, deps, scopeDeps) ->
			if angular.isObject deps[0]
				parent::__ClassyControllerInjectObject = injectObject = deps[0]
				deps = (service for service, name of injectObject)

				scopeName = parent::__options._scopeName
				if injectObject?[scopeName] and injectObject[scopeName] != '.'
					parent::__options._scopeName = injectObject[scopeName]

			# Add the `deps` to the controller's $inject annotations.
			parent.$inject = deps
			parent.$inject = parent.$inject.concat scopeDeps if scopeDeps? and angular.isArray scopeDeps

		registerSelector: (appInstance, selector, parent) ->
			@selectorControllerCount++
			controllerName = "ClassySelector#{@selectorControllerCount}Controller"
			appInstance.controller controllerName, parent

			if angular.isElement(selector)
				selector.setAttribute('data-ng-controller', controllerName)
				return

			if angular.isString(selector)
				# Query the dom using jQuery if available, otherwise fallback to qSA
				els = window.jQuery?(selector) or document.querySelectorAll(selector)
			else if angular.isArray(selector)
				els = selector
			else return

			for el in els
				if angular.isElement(el)
					el.setAttribute('data-ng-controller', controllerName)

		create: (appInstance, classObj, parent) ->
			if classObj.el || classObj.selector
				# Register the controller using selector
				@registerSelector(appInstance, classObj.el || classObj.selector, parent)

			if angular.isString(classObj.name)
				# Register the controller using name
				appInstance.controller classObj.name, parent

			deps = classObj.inject or []
			deps = appInstance.classy.options.commonInjections.concat deps
			scopeDeps = classObj.injectToScope or []
			scopeDeps = appInstance.classy.options.commonInjectionsToScope.concat scopeDeps
			scopeDeps_injectable = _.object scopeDeps, scopeDeps
			scopeDeps_injectable[k] = _.first v.split '.' for k, v of scopeDeps_injectable when classFns.__isCompositeDep v
			scopeDepsObj[classObj.name] = scopeDeps

			# Inject the `deps` if it's passed in as an array
			if angular.isArray(deps) then @inject(parent, deps, _.uniq _.values scopeDeps_injectable)

			# If `deps` is object: Wrap object in array and then inject
			else if angular.isObject(deps) then @inject(parent, [deps])