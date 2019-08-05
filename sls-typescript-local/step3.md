# Testing

Furthermore **gts** will let you define a test framework of your choice.
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

Because we declared our test directory in *tsconfig.json* as *test/*
we need to create the dir and also a spec file.
`mkdir test`{{execute}}
`touch test/handler.spec.ts`{{execute}}

And copy

```ts
import { describe, it } from 'mocha';
import { expect } from 'chai';

import { hello } from '../src';

describe('simple test example', () => {
  it('adds two numbers', async () => {
    const expected = 200;
    const res = await hello({});
    expect(res.statusCode).to.be.eqls(expected);
  });
});

```

to *test/handler.spec.ts*

Let's fix some style errors

`npm run fix`{{execute}}

Please change the *script* part in *package.json*.
Add/Change the following (leave the other script parts).

```json
"test": "mocha -r ts-node/register test/*.spec.ts",
"test:coverage": "nyc npm run test",
```

Now you have 2 more run comands

`npm run test`{{execute}}

This runs the tests.

We are using nyc as a coverage tool. To configure it copy

```json
"nyc": {
    "extension": [
      ".ts",
      ".tsx"
    ],
    "exclude": [
      "**/*.d.ts"
    ],
    "all": true  
  }
```

to your package.json.

`npm run test:coverage`{{execute}}

This runs the tests with coverage report.
