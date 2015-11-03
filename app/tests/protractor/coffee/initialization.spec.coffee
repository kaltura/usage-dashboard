describe 'Initialization', ->

	it 'should redirect from / to /usage-dashboard', ->
		browser.get(url '/').then ->
			browser.getCurrentUrl().then (url) ->
				expect(url.indexOf 'usage-dashboard').toBeGreaterThan length()

	it 'should redirect from wrong paths to /usage-dashboard', ->
		browser.get(url '/asd').then ->
			browser.getCurrentUrl().then (url) ->
				expect(url.indexOf 'usage-dashboard').toBeGreaterThan length()
		browser.get(url '/usage-dashboard/gwerw').then ->
			browser.getCurrentUrl().then (url) ->
				expect(url.indexOf 'usage-dashboard').toBeGreaterThan length()
		browser.get(url '//gwerw/bfqg').then ->
			browser.getCurrentUrl().then (url) ->
				expect(url.indexOf 'usage-dashboard').toBeGreaterThan length()

	it 'should redirect from /usage-dashboard to /usage-dashboard/overall-usage', ->
		browser.get(url '/usage-dashboard').then ->
			browser.getCurrentUrl().then (url) ->
				expect(url.indexOf 'usage-dashboard/overall-usage').toBeGreaterThan length()