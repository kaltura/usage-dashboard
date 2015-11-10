describe 'Plays Report', ->

	beforeEach ->
		browser.get(url '/usage-dashboard/plays').then ->
			browser.waitForAngular()

	describe 'Controls row', ->

		clickOnSelect = ->
			click($ '.select2-container a').then =>
				log "browser.waitForAngular = #{_.isFunction browser.waitForAngular}"
				log "browser.waitForAngular().then = #{_.isFunction browser.waitForAngular().then}"
				browser.waitForAngular()

		getSelectItems = ->
			$$ '.select2-results li'

		clickAndGetSelectItems = ->
			clickOnSelect().then ->
				getSelectItems().then (items) ->
					items.count().then log
					items

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


		describe 'Select Items', ->

			forEachLi = (fn) =>
				browser.executeScript( ->
					injector = angular.element('[ng-app]').injector()
					injector.get('reportControlsSelectCollection').arr
				).then (ranges) =>
					clickAndGetSelectItems().then (items) ->
						for li, index in items
							do (li, index) ->
								fn li, ranges[index]

			it 'Select should be opened when clicked', ->
				clickAndGetSelectItems().then (items) ->
					log items
					# expect(items.count()).toBeDefined()
					# expect(items.count()).toBe 4

			xit 'correct range names should be listed in select in correct order', =>
				forEachLi (li) ->
					expect(li.getText()).toContain ranges[index].name

			xit 'select should update its model', =>
				forEachLi (li, range) =>
					click(li).then =>
						browser.waitForAngular().then =>
							expect(@controls.evaluate 'select.model').toEqual range.id

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
