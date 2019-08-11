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
[Google code style](
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
`touch src/handler.ts`{{execute}}
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

`npx sls invoke local -f hello`{{execute}}

Please keep in mind that you need to build `npm run compile`{{execute}} before
you are able to invoke the code.

Without the *local* you call the deployed lambda at AWS but this is not
part of the scenario.
