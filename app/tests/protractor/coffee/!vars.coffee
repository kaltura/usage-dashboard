q = require 'q'
_ = require 'lodash'
fs = require 'fs'
Domain = 'http://localhost:9000'

length = -> Domain.length - 2
url = (url='/') ->
	"#{Domain}#{url}#{if browser.params.ks? then '?ks='+browser.params.ks else ''}"
log = (text) ->
	console.log "##### #{text}"
click = (element) ->
	browser.actions().mouseDown(element).mouseUp(element).perform()

beforeEach ->
	browser.get url '/'
	browser.driver.manage().window().maximize()