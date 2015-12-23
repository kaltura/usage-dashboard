# vpaas-usage-dashboard

VPaaS Usage Dashboard frontend (Angular.js)

## Preparations

> npm install

> bower install

## Serving

### Development version

Builds, watches and serves project without minification and concatenation

The local server starts at `localhost:9000`

> grunt

which is equal to

> grunt serve:development

### Production version

Builds, watches and serves project with js concatenation and minification

The local server starts at `localhost:9000`

> grunt serve:production

## Build only

### Development version

> grunt build

which is equal to

> grunt build:development

### Production version

> grunt build:production

This also creates a zip package in `packages` folder with name as version taken from bower.json

## Tests

### E2E tests

> npm install -g protractor

> npm install

> node_modules/grunt-webdriver-manager/bin/webdriver-manager update

*Important!* webdriver-manager update this must be ran exactly in that folder

> grunt e2e:target:ks

Where

- `target` is 'development' or 'production'. *Default:* 'development'
- 'ks' is kaltura login token (kmc.vars.ks) which would be passed to app during testing (a way to append ?ks=<ks> as a url parameter to all urls)

## Deploying to github pages

> git checkout gh-pages

> git pull github master

Proceed a merge if necessary

> git push origin gh-pages
