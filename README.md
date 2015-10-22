# Kaltura VPaaS Usage Dashboard

Kaltura VPaaS Usage Dashbaord frontend (Angular.js)

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

## Deploying to github pages

> git checkout gh-pages

> git pull github master

Proceed a merge if necessary

> git push origin gh-pages