describe 'Header', ->

	describe 'Menu', ->

		beforeEach =>
			element.all(By.css '.usage-dashboard-header').all(By.repeater 'item in items').then (@items) =>

		it 'should have one menu item, named "Account Usage Reports"', =>
			expect(@items.length).toBe 1
			expect(@items[0].$('a').getText()).toBe 'Account Usage Reports'

		it '"Account Usage Reports" menu item should lead to /usage-dashboard', =>
			@items[0].click().then ->
				browser.getCurrentUrl().then (url) ->
					expect(url.indexOf '/usage-dashboard').toBeGreaterThan length()

		it '"Account Usage Reports" menu item has to be highlighted', =>
			expect($$('.usage-dashboard-header-menu .active').count()).toBe 1