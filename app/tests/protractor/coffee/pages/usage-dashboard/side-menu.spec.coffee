describe 'Side Menu', ->

	beforeEach =>
		element.all(By.css '.side-menu').all(By.repeater 'menuItem in menuItems').then (@items) =>

	xit 'should be 6 menu items', => expect(@items.length).toBe 6

	xit 'should redirect to corresponding pages on menu items clicks', =>
		promise = q.when()
		for item in @items
			promise = promise.then ->
				do (item) ->
					item.click().then ->
						item.evaluate('menuItem').then (menuItem) ->
							browser.getCurrentUrl().then (url) ->
								expect(url.indexOf '/usage-dashboard').toBeGreaterThan length()
								expect(url.indexOf menuItem.url).toBeGreaterThan length()

	xit 'should highlight hovered menu item', =>
		item = _.sample(@items).$ 'span'
		item.getCssValue('text-shadow').then (val) ->
			split = (val) ->
				_.filter(val.split(' '), (s) -> s.indexOf('px') > -1).map parseInt
			expect(_.compact(split val).length).toBe 0
			browser.actions().mouseMove(item).perform().then ->
				browser.wait ->
					item.getCssValue('text-shadow').then (val) ->
						_.compact(split val).length > 0
				, 1000

	xit 'should distinguish the current menu item', =>
		browser.getCurrentUrl().then (url) =>
			loop
				item = _.sample @items
				break unless url.indexOf(item.url) >= 0
			click(item).then ->
				browser.waitForAngular().then ->
					browser.wait ->
						item.getAttribute('class').then (cls) ->
							cls.split(' ').indexOf('active') > -1
					, 1000