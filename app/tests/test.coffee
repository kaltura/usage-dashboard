describe 'E2E tests', ->

	beforeEach module 'KalturaUsageDashboard'
	beforeEach browser().navigateTo '/'

	it 'should', ->
		browser.get 'https://angularjs.org'
		element(by.model('todoList.todoText')).sendKeys('write first protractor test')
		element(by.css('[value="add"]')).click()

		var todoList = element.all(by.repeater('todo in todoList.todos'))
		expect(todoList.count()).toEqual(3)
		expect(todoList.get(2).getText()).toEqual('write first protractor test')

		todoList.get(2).element(by.css('input')).click()
		var completedAmount = element.all(by.css('.done-true'))
		expect(completedAmount.count()).toEqual(2)