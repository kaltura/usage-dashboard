describe 'Side Menu', ->

	beforeEach =>
		element.all(By.css '.side-menu').all(By.repeater 'menuItem in menuItems').then (@items) =>

	it 'should be 6 menu items', => expect(@items.length).toBe 6

	it 'should redirect to corresponding pages on menu items clicks', =>
		promise = q.when()
		for item in @items
			promise = promise.then ->
				do (item) ->
					item.click().then ->
						item.evaluate('menuItem').then (menuItem) ->
							browser.getCurrentUrl().then (url) ->
								expect(url.indexOf '/usage-dashboard').toBeGreaterThan length()
								expect(url.indexOf menuItem.url).toBeGreaterThan length()

	it 'should highlight hovered menu item', =>
		item = _.sample(@items).$ 'span'
		item.getCssValue('text-shadow').then (val) ->
			split = (val) ->
				_.filter(val.split(' '), (s) -> s.indexOf('px') > -1).map parseInt
			expect(_.compact(split val).length).toBe 0
			browser.actions().mouseMove(item).perform().then ->
				console.log browser.timeouts
				browser.timeouts().setScriptTimeout().then ->
					item.getCssValue('text-shadow').then (val) ->
						expect(_.compact(split val).length).not.toBe 0

	it 'should distinguish the current menu item', =>
		browser.getCurrentUrl().then (url) =>
			loop
				item = _.sample @items
				break unless url.indexOf(item.url) >= 0
			item.click().then ->
				browser.timeouts().setScriptTimeout().then ->
					item.getAttribute('class').then (cls) ->
						log cls
						expect(cls.split(' ').indexOf 'active').toBeGreaterThan -1