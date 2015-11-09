describe 'Plays Report', ->

	beforeEach ->
		browser.get(url '/usage-dashboard/plays').then ->
			browser.waitForAngular()

	describe 'Controls row', ->

		_.extend @,
			findLiByRange: (range) =>
				log range.name
				q.all([li.getText() for li in @selectLis]).then (texts) ->
					li = _.find texts, (text) ->
						text.indexOf(range.name) > -1
					log li
					range.li = li
					range

			getDefaultRange: =>
				browser.executeScript( ->
					injector = angular.element('[ng-app]').injector()
					(injector.get 'reportControlsSelectCollection').singleWhere default: yes
				).then (range) =>
					@findLiByRange range

			getDatepickersRange: =>
				browser.executeScript( ->
					injector = angular.element('[ng-app]').injector()
					(injector.get 'reportControlsSelectCollection').singleWhere allowDatepickers: yes
				).then (range) =>
					@findLiByRange range

		beforeEach =>
			browser.waitForAngular().then =>
				@controls = $ '.controls-row'
				@select = @controls.$ '.select'
				@datepickers = @controls.$ '.dates'

				@datepickerDiv = $ '#ui-datepicker-div'
				@selectUl = $ '.select2-drop'
				@selectLis = @selectUl.$$ 'li'

		it 'should have controls row', =>
			@controls.isPresent()

		it 'should have select', =>
			@select.isPresent()

		it 'should have datepickers', =>
			@datepickers.isPresent()

		it 'Default value should be prepopulated in select', =>
			@getDefaultRange().then (range) =>
				expect(@select.$('.select2-chosen').getText()).toEqual range.name

		describe 'Select Items', =>
			forEachLi = (fn) =>
				browser.executeScript( -> ->
						injector = angular.element('[ng-app]').injector()
						injector.get('reportControlsSelectCollection').arr
				).then (ranges) =>
					for li, index in @selectLis
						do (li, index) ->
							fn li, ranges[index]

			it 'correct range names should be listed in select in correct order', =>
				forEachLi (li) ->
					expect(li.getText()).toContain ranges[index].name

			it 'select should update its model', =>
				forEachLi (li, range) =>
					click(li).then =>
						browser.waitForAngular().then =>
							expect(@controls.evaluate 'select.model').toEqual range.id

			it 'should enable datepickers only if they are allowed by selection in select', =>
				forEachLi (li, range) =>
					click(li).then =>
						browser.waitForAngular().then =>
							expect(@datepickers.isDisplayed()).toBe range.allowDatepickers

		it 'should open datepicker when clicking on inputs', =>
			@getDatepickersRange().then (range) =>
				click(range.li).then =>
					expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()
					click(@datepickers.$$('.datepicker input')[0]).then =>
						expect(@datepickerDiv.isDisplayed()).toBeTruthy()

		it 'should open datepicker when clicking on icon', =>
			@getDatepickersRange().then (range) =>
				click(range.li).then =>
					expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()
					click(@datepickers.$$('.datepicker .icon')[0]).then =>
						expect(@datepickerDiv.isDisplayed()).toBeTruthy()

		it 'should close datepicker when clicked away', =>
			@getDatepickersRange().then (range) =>
				click(range.li).then =>
					expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()
					click(@datepickers.$$('.datepicker .icon')[0]).then =>
						expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()
						click($('body')).then =>
							expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()


	describe 'CSV', ->

		beforeEach =>
			@csv = $ '.export-to-csv'

		it 'should have button to export csv', =>
			@csv.isPresent()
