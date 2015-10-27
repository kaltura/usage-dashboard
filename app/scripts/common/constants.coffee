do ->

	module = angular.module 'KalturaUsageDashboard.constants', []

	module.service 'constants', [
		'ModuleConsolidator',
		(ModuleConsolidator) ->
			new ModuleConsolidator module
	]


	module.constant 'dayms', 1000*60*60*24


	module.constant 'graph',
		colorColumn: '#02a3d1'
		colorAxis: '#c2d2e1'
		colorText: '#585858'
		mainBg: '#f0eeef'
		borderWidth: 7
		labelRotation:
			tiny: 10
			small: 14
			medium: 19
			large: 26
			full: 32
		dataDecorators:
			months: (months) ->
				for month in months
					monthDate = new Date month.dates[0]
					if month.dates.length isnt monthDate.nDaysInMonth() and monthDate.toYMn() in [months.dates.from.toYMn(), months.dates.to.toYMn()]
						firstDate = monthDate.getDate()
						lastDate = month.dates[month.dates.length-1].getDate()
						month.label = "#{firstDate}#{if firstDate isnt lastDate then '-' + lastDate else ''} #{month.label}"


	module.constant 'columns',
		default: [
			title: 'Month'
			field: 'label'
		]
		reports:
			plays: [
				title: 'Plays (CPM)'
				field: 'count_plays'
			]
			storage: [
				title: 'Average Storage (GB)'
				field: 'average_storage'
			]
			bandwidth: [
				title: 'Bandwidth Consumption (GB)'
				field: 'bandwidth_consumption'
			]
			'transcoding-consumption': [
				title: 'Transcoding Consumption (GB)'
				field: 'transcoding_consumption'
			]
			'media-entries': [
				title: 'Total'
				field: 'count_total'
			,
				title: 'Video'
				field: 'count_video'
			,
				title: 'Audio'
				field: 'count_audio'
			,
				title: 'Images'
				field: 'count_image'
			]
			'overall-usage': [
				title: 'Plays (CPM)'
				field: 'count_plays'
			,
				title: 'Average Storage (GB)'
				field: 'average_storage'
			,
				title: 'Transcoding Consumption (GB)'
				field: 'transcoding_consumption'
			,
				title: 'Bandwidth Consumption (GB)'
				field: 'bandwidth_consumption'
			,
				title: 'Media Entries'
				field: 'count_total'
			,
				title: 'End Users'
				field: 'end_users'
			]


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

		contains: (str) -> @indexOf(str) >= 0

	module.constant 'NumberPrototype',
		isFloat: -> @ % 1 isnt 0

	module.constant 'NumberExtension',
		round: (n, nDecimalPlaces=0) ->
			rank = Math.pow 10, nDecimalPlaces
			Math.round(n * rank) / rank


	module.service 'DatePrototype', [
		'$filter'
		'dayms'
		($filter, dayms) ->

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

			toYMDn: -> parseInt @toYMD().replace /\-/g, ''

			toYM: ->
				$filter('date') @, 'yyyy-MM'

			toYMn: -> parseInt @toYM().replace /\-/g, ''

			subMonth: (nMonths = 1) ->
				@setMonth @getMonth() - nMonths
				@

			nDaysInMonth: ->
				d = new Date @
				d.setMonth d.getMonth() + 1
				d.setDate 0
				d.getDate()

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

			nMonths: -> @getFullYear() * 12 + @getMonth() - 11
	]

	module.constant 'DateExtension',
		#from number like 20151023, where 2015 - year, 10 - month, 23 - date
		fromYMDn: (n) ->
			new Date Math.floor(n / 10000), Math.floor(n % 10000 / 100 - 1), n % 100

		#from number like 201510, where 2015 - year, 10 - month
		fromYMn: (n) ->
			new Date Math.floor(n / 100), n % 100 - 1

		#from number like YMDn or YMn
		fromn: (n) ->
			Date[switch "#{n}".length
				when 6 then 'fromYMn'
				when 8 then 'fromYMDn'
			] n

		#string like "2015-10-23"
		fromYMD: (str) -> new Date str

		#string like "2015-10"
		fromYM: (str) -> new Date "#{str}-01"

		nMonths: (d1, d2) -> (new Date d2).nMonths() - (new Date d1).nMonths()