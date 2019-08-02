# Basic setup

First Now we need to init our **npm** project for **typescript** with **gts**

`npx gts init`{{execute}}

We overwrite the dev dependency versions here.
**tsconfig.json need to be overwritten for this scenario**

You get some stuff here:

- Npm setup in **package.json**
- State of the art typescript compiler options in **tsconfig.json**
- Lint checker with google typescript style conventions in **tslint.json**
- Formatter options for google typescript style conventions in **prettier.conf.js**

The style settings are taken from
[![Code Style: Google](https://img.shields.io/badge/code%20style-google-blueviolet.svg)](
    https://github.com/google/gts)

Just try it out

`npm run check`{{execute}}

Fix the lint errors:

`npm run fix`{{execute}}

Test again

`npm run check`{{execute}}

Now we need to install serverless.
We use sls with a template here.

`npm install -D serverless`{{execute}}

`npx sls create --template aws-nodejs`{{execute}}

`npm ci`{{execute}}

Because *handler.js* is no valid typescript we need to adjust it a bit.
To keep it easy we just create a new file
`touch src/handler.ts/`{{execute}}
and delete the javascript handler
`rm handler.js`{{execute}}

Copy

```ts
export const hello = async (event: {}): Promise<{
  statusCode: number;
  body: string;
}> => {
  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: 'Go Serverless v1.0! Your function executed successfully!',
        input: event,
      },
      null,
      2
    ),
  };

  // Use this code if you don't use the http event with the LAMBDA-PROXY integration
  // return { message: 'Go Serverless v1.0!
  // Your function executed successfully!', event };
};
```

to *src/handler.ts*

Just to hava a runable node module we change *src/index.ts*
`rm src/index.ts`{{execute}}
`echo "export * from './handler';" > src/index.ts`{{execute}}

Because we changed the build directory to *build/* we need to adjust *serverless.yml*

```yaml
functions:
  hello:
    handler: handler.hello
```

to

```yaml
functions:
  hello:
    handler: build/src/handler.hello
```

We also want to use **npm scripts** as build tool add the following script
to your *package.json* script part:

```json
"package": "npm run compile && sls package"
```

When you run `npm run package`{{execute}}
you get an artifact folder *.serverless* with a built cloudformation template.

Now we want to test the lambda locally:

```bash
npx sls invoke local -f hello
```

Please keep in mind that you need to build `npm run compile`{{execute}} before
you are able to invoke the code.

Without the *local* you call the deployed lambda at AWS but this is not
part of the scenario.

Now we also want to test the API. Therefore we install
[serverless-offline](
  https://www.npmjs.com/package/serverless-offline)

`npm install serverless-offline -D`{{execute}}

You also need to adjust *serverless.yml* plugin part

```yaml
plugins:
  - serverless-offline
```

Also we need to set the API event in *serverless.yml*

```yaml
functions:
  hello:
    handler: build/src/handler.hello
    events:
      - http:
          path: hello
          method: get
          cors: true
```

Per default you can send your request to `http://localhost:3000/`
Please see the
[documentation](
  https://www.npmjs.com/package/serverless-offline)
for configuration details

You can start the container at host in another terminal

`npx sls offline`{{execute T2}}

Or you can start it with docker in detached mode

`docker run -v="${PWD}:/app/" -p="3000:3000" -w="/app/" node:12.7-alpine npx sls offline`{{execute}}

now you are able to query the API

`curl -X GET http://localhost:3000/hello`{{execute}}

You can see that the event in the lambda is getting a lot of parameter.

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

Please change the *script* part in *package.json*.
Add/Change the following (leave the other script parts).

```json
"test": "mocha -r ts-node/register test/**/*.spec.ts",
"test:coverage": "nyc npm run test"
```

Now you have 2 more run comands

`npm run test`{{execute}}

This runs the tests.

`npm run test:coverage`{{execute}}

This runs the tests with coverage report.
