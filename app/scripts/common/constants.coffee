do ->

	module = angular.module 'KalturaUsageDashboard.constants', []


	module.constant 'dayms', 1000*60*60*24


	module.constant 'graph',
		colorColumn: '#02a3d1'
		colorAxis: '#c2d2e1'
		mainBg: '#f0eeef'
		borderWidth: 7


	module.constant 'ArrayPrototype',
		byField: (field, value) ->
			for e, index in @
				if e[field] is value
					return @[index]

		each: (fn) -> fn e, index, @ for e, index in @

		contains: (k) ->
			if k
				for e, index in @
					return yes if k.id? and e.id is k.id  or @[index] is k  or e.id is k
			no

		pushArray: (arr) ->
			if arr and arr.length
				@push e for e in arr
			@

		replace: (wht, wth) ->
			@[index] = wth for e, index in @ when e is wht

		remove: (item) ->
			for i, index in @
				if item is i
					@splice index, 1
					break
			item

		clear: ->
			@remove @[0] while @length
			@


	module.constant 'StringPrototype',

		noSpaces: -> @replace /\s/g, ''

		splice: (idx, rem, s) -> @slice(0, idx) + s + @slice idx + Math.abs(rem)

		nMatches: (str) ->
			r = new RegExp str, 'g'
			(@match(r) or []).length

		nPoints: -> @nMatches '\\\.'


	module.service 'DatePrototype', ($filter, dayms) ->

		fullzero: ->
			@setYear 0
			@setMonth 0
			@setDate 1
			@zero()

		zero: ->
			@setHours 0, 0, 0, 0
			@
			
		dateTimeZoneFix: -> new Date @setHours @getHours() + @getTimezoneOffset() / 60

		toMonthStart: ->
			@setDate 1
			@

		toMonthEnd: ->
			@setMonth @getMonth() + 1
			@setDate 0
			@

		toYMD: -> $filter('date') @, 'yyyy-MM-dd'

		toMDY: -> $filter('date') @

		#date greater (@ > date ?) comparison in DAYS context
		dg: (date) ->
			v1 = @valueOf() / dayms
			v2 = (new Date date).valueOf() / dayms
			v1 > v2

		#date smaller (@ < date ?) comparison in DAYS context
		ds: (date) -> (new Date date).dg @

		#date greater or equals (@ >= date ?) comparison in DAYS context
		dge: (date) ->
			v1 = @valueOf() / dayms
			v2 = (new Date date).valueOf() / dayms
			v1 >= v2

		#date smaller or equals (@ <= date ?) comparison in DAYS context
		dse: (date) -> (new Date date).dge @

		#date equals (@ = date ?) comparison in DAYS context
		de: (date) ->
			v1 = @valueOf() / dayms
			v2 = (new Date date).valueOf() / dayms
			v1 is v2

		#date greater (@ > date ?) comparison by milliseconds
		dg_ms: (date) ->
			v1 = @valueOf()
			v2 = (new Date date).valueOf()
			v1 > v2

		#date smaller (@ < date ?) comparison by milliseconds
		ds_ms: (date) ->
			v1 = @valueOf()
			v2 = (new Date date).valueOf()
			v1 < v2

		#date greater or equals (@ >= date ?) comparison by milliseconds
		dge_ms: (date) ->
			v1 = @valueOf()
			v2 = (new Date date).valueOf()
			v1 >= v2

		#date smaller or equals (@ <= date ?) comparison by milliseconds
		dse_ms: (date) ->
			v1 = @valueOf()
			v2 = (new Date date).valueOf()
			v1 <= v2

		#date greater than now (@ > now ?) comparison by milliseconds
		dgNow: -> @dg_ms new Date


		#date smaller than now (@ < now ?) comparison by milliseconds
		dsNow: -> @ds_ms new Date

		#date equals (@ = date ?) comparison by year, month, day
		de_ymd: (date) ->
			d1 = new Date @
			d2 = new Date date
			v1 = (d1.setHours 0,0,0,0).valueOf() / dayms
			v2 = (d2.setHours 0,0,0,0).valueOf() / dayms
			v1 is v2

		#time greater or equals (hours and minutes)
		tge: (date) ->
			d2 = new Date date
			d1 = new Date @
			h1 = d1.getHours()
			h2 = d2.getHours()
			m2 = d2.getMinutes()
			m1 = d1.getMinutes()
			h1*60 + m1 >= h2*60 + m2

		#time equals (hours and minutes)
		te: (date) ->
			d1 = new Date @
			d2 = new Date date
			h1 = d1.getHours()
			h2 = d2.getHours()
			m1 = d1.getMinutes()
			m2 = d2.getMinutes()
			h1 is h2 and m1 is m2

		#time equals (hours, minutes and seconds)
		tse: (date) ->
			d1 = new Date @
			d2 = new Date date
			h1 = d1.getHours()
			h2 = d2.getHours()
			m1 = d1.getMinutes()
			m2 = d2.getMinutes()
			s1 = d1.getSeconds()
			s2 = d2.getSeconds()
			h1 is h2 and m1 is m2 and s1 is s2

		isInMonth: (date) ->
			date = new Date date
			date.getFullYear() is @getFullYear() and date.getMonth() is @getMonth()

		isInPreviousMonth: (date) ->
			date = new Date date
			@isInMonth date.setMonth date.getMonth() - 1