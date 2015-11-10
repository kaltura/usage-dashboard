describe 'Plays Report', ->

	beforeEach ->
		browser.get(url '/usage-dashboard/plays').then ->
			browser.waitForAngular()

	describe 'Controls row', ->

		clickOnSelect = ->
			click($ '.select2-container a').then ->
				browser.waitForAngular()

		getSelectItems = ->
			$$ '.select2-results li'

		clickAndGetSelectItems = ->
			clickOnSelect().then getSelectItems
			#select remains opened!

		findLiByRange = (range) ->
			clickAndGetSelectItems().then (items) ->
				q.all([li.getText() for li in items]).then (texts) ->
					li = _.find texts, (text) ->
						text.indexOf(range.name) > -1
					range.li = li
					range

		getDefaultRange = ->
			browser.executeScript( ->
				injector = angular.element('[ng-app]').injector()
				(injector.get 'reportControlsSelectCollection').singleWhere default: yes
			).then (range) ->
				findLiByRange range

		getDatepickersRange = ->
			browser.executeScript( ->
				injector = angular.element('[ng-app]').injector()
				(injector.get 'reportControlsSelectCollection').singleWhere allowDatepickers: yes
			).then (range) ->
				findLiByRange range

		beforeEach =>
			browser.waitForAngular().then =>
				@controls = $ '.controls-row'
				@select = @controls.$ '.select'
				@datepickers = @controls.$ '.dates'
				@datepickerDiv = $ '#ui-datepicker-div'

		xit 'should have controls row', =>
			@controls.isPresent()

		xit 'should have select', =>
			@select.isPresent()

		xit 'should have datepickers', =>
			@datepickers.isPresent()

		xit 'Default value should be prepopulated in select', =>
			getDefaultRange().then (range) =>
				expect(@select.$('.select2-chosen').getText()).toEqual range.name


		describe 'Select Items', =>

			getRanges = ->
				browser.executeScript ->
					injector = angular.element('[ng-app]').injector()
					injector.get('reportControlsSelectCollection').arr

			forEachLi = (fn) ->
				getRanges().then (ranges) ->
					promise = q.when()
					for range, index in ranges
						do (range, index) ->
							promise = promise.then ->
								clickAndGetSelectItems().then (items) ->
									fn(items[index], range).then ->
										#close select after each iteration
										clickOnSelect()

			xit 'Select should be opened when clicked', ->
				clickAndGetSelectItems().then (items) ->
					getRanges().then (ranges) ->
						expect(items.length).toBeDefined()
						expect(items.length).toBe ranges.length

			xit 'correct range names should be listed in select in correct order', ->
				forEachLi (li, range) ->
					li.getText().then (text) ->
						expect(text).toContain range.name

			xit 'select should update its model', =>
				forEachLi (li, range) =>
					click(li).then =>
						browser.waitForAngular().then =>
							@select.evaluate('select.model').then (model) ->
								expect(model).toEqual range.id

			xit 'should enable datepickers only if they are allowed by selection in select', =>
				forEachLi (li, range) =>
					click(li).then =>
						browser.waitForAngular().then =>
							expect(@datepickers.isDisplayed()).toBe range.allowDatepickers

		describe 'Datepickers', =>

			xit 'should open datepicker when clicking on inputs', =>
				getDatepickersRange().then (range) =>
					click(range.li).then =>
						expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()
						click(@datepickers.$$('.datepicker input')[0]).then =>
							expect(@datepickerDiv.isDisplayed()).toBeTruthy()

			xit 'should open datepicker when clicking on icon', =>
				getDatepickersRange().then (range) =>
					click(range.li).then =>
						expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()
						click(@datepickers.$$('.datepicker .icon')[0]).then =>
							expect(@datepickerDiv.isDisplayed()).toBeTruthy()

			xit 'should close datepicker when clicked away', =>
				getDatepickersRange().then (range) =>
					click(range.li).then =>
						expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()
						click(@datepickers.$$('.datepicker .icon')[0]).then =>
							expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()
							click($('body')).then =>
								expect(@datepickerDiv.isDisplayed()).not.toBeTruthy()


	describe 'CSV', ->

		beforeEach =>
			@csv = $ '.export-to-csv'

		xit 'should have button to export csv', =>
			@csv.isPresent()
