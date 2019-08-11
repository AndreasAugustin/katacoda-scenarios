# version and publishing

Lerna is working hardly connected to git. Let's see

`cd ~/git/npm-lerna`{{execute}}

`npx lerna version`{{execute}}

*Lerna* is using [semantic versioning](https://semver.org/).
Choose **minor** version and y.
You see that you need to login with your git credentials.
If you check on
[gitea](
    https://[[HOST_SUBDOMAIN]]-30002-[[KATACODA_HOST]].environments.katacoda.com/)

You see that *lerna* also pushed the commit and created a git tag.
Furthermore it changed all packages version.

Now replace the content of `packages/foo/src/index.ts` with

```ts
export const add = (a: number, b: number): number => {
  return a + b;
}

```

Return to lerna root

`cd ~/git/npm-lerna`{{execute}}

Let's fix some style issues

`npx lerna run fix`{{execute}}

Build the project foo

`npx lerna run --scope @npm-lerna/foo compile`{{execute}}

Now we want to use the compiled lib in the *bar* project.

`npx lerna add @npm-lerna/foo packages/bar`{{execute}}

Check the content of *bar* `package.json`

`cat packages/bar/package.json`{{execute}}

You see that there is a new dependency added to *foo*.

Replace the content of `packages/bar/src/index.ts` with

```ts
import {add} from '@npm-lerna/foo'

export const calc = () => {
  const res = add(1, 2);

  return res;
};

```

Go back to npm-lerna root

`cd ~/git/npm-lerna`{{execute}}

Fix some lint errors

`npx lerna run fix`{{execute}}

Check if it compiles

`npx lerna run compile`{{execute}}

Now we use *foo* in our project *bar*.

Let's persist our change

`cd ~/git/npm-lerna`{{execute}}

`git status`{{execute}}

`git add .`{{execute}}

`git commit -m "Some project implementation"`{{execute}}

Also we want to publish our node project to
[verdaccio](
  https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com/)

`npx lerna publish --registry http://localhost:30001`{{execute}}

Click the verdaccio tab in the terminal or the link above to see the stuff we published.

Now we also want to have a function for subtraction.
Add to *foo*`packages/foo/src/index.ts`

```ts
export const sub = (a: number, b: number): number => {
  return a - b;
}

```

And change `packages/bar/src/index.ts` to

```ts
import {add, sub} from '@npm-lerna/foo'

export const calc = () => {
  const res1 = add(1, 2);
  const res2 = sub(res1, 3);

  return res2;
};

```

Now lets compile it (will have an error)

`cd ~/git/npm-lerna`{{execute}}

`npx lerna run compile`{{execute}}

As you can see, the project *bar* has still the old version of *foo*.
We need to `bootstrap` the project to receive the actual stuff.

`npx lerna bootstrap`{{execute}}

This is also needed, when you clone a project from **git**.

Now let's `publish` again.

`npx lerna publish`{{execute}}
