# Testing

**gts** will let you define your test framework of your choice.
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

Now please change the *script* part in *package.json*.
Add/Change the following (leave the other script parts).

```json
"scripts": {
    "test": "mocha -r ts-node/register test/**/*.spec.ts",
    "test:coverage": "nyc npm run test",
}
```

Now you have 2 more run comands

`npm run test`{{execute}}

This runs the tests.

`npm run test:coverage`{{execute}}

This runs the tests with coverage report.
