# Basic setup

First we need to init our **npm** project for **typescript**.

`npx gts init`{{execute}}

You get some stuff here:

- Npm setup in **package.json**
- State of the art typescript compiler options in **tsconfig.json**
- Lint checker with google typescript style conventions in **tslint.json**
- Formatter options for google typescript style conventions in **prettier.conf.js**

The style settings are taken from
[![Code Style: Google](https://img.shields.io/badge/code%20style-google-blueviolet.svg)](
    https://github.com/google/gts)

**gts** will let you define a test framework of your choice.
For this scenario we choose

- [mocha](https://www.npmjs.com/package/mocha) for the testing framework
- [chai](https://www.npmjs.com/package/chai) for the assertion lib
- [nyc](https://www.npmjs.com/package/nyc) for test coverage
- [ts-node](https://www.npmjs.com/package/ts-node)

We need to install those libs.

`npm i -D chai mocha nyc ts-node`{{execute}}

Because we also need the types declaration files for typescript,
we also need to install those

`npm i -D @types/mocha @types/chai`{{execute}}
