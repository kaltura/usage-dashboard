Domain = 'http://localhost:9000'
length = -> Domain.length - 2
url = (url='/') ->
	"#{Domain}#{url}#{if browser.params.ks? then '?ks='+browser.params.ks else ''}"

beforeEach ->
	browser.get url '/'
	browser.manage().window().setSize 1280, 1024