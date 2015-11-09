exports.config = {
  framework: 'jasmine2',
  seleniumAddress: 'http://localhost:4444/wd/hub',
  capabilities: {
    browserName: 'chrome'
  },
  specs: ['specs/**/*.js'],
  jasmineNodeOpts: {
    showColors: true
  },
  onPrepare: function() {
    browser.driver.manage().window().maximize();
  }
}