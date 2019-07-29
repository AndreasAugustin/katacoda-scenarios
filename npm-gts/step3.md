# Testing

Please change the *script* part in *package.json*.
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
