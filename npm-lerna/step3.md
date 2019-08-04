# version and publishing

Lerna is working hardly connected to git. Let's see

`cd ~/git/npm-lerna`{{execute}}

`npx lerna version`{{execute}}

Choose minor version and y.
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

Build the project foo

`npx lerna run --scope @npm-lerna/foo compile`{{execute}}

Now we want to use the compiled lib in the *bar* project.

`npx lerna add @npm-lerna/foo projects/bar`{{execute}}

Check the content of *bar* `package.json`

`cat projects/bar/package.json`{{execute}}

Replace the content of `packages/foo/src/index.ts` with

```ts
import {add} from '@npm-lerna/foo'

export const calc = () => {
  const res = add(1, 2);

  return res;
};
```

Check if it compiles

`cd ~/git/npm-lerna`{{execute}}

`npx lerna run compile`{{execute}}

Now we use *foo* in our project *bar*.

Let's persist our change

`cd ~/git/npm-lerna`{{execute}}

`git status`{{execute}}

`git add .`{{execute}}

`git commit -m "Some project implementation"`{{execute}}

Also we want to publish our node project to
[verdaccio](
  https://[[HOST_SUBDOMAIN]]-30002-[[KATACODA_HOST]].environments.katacoda.com/)

`npx lerna publish`{{execute}}

Click the verdaccio tab in the terminal or the link above to see the stuff we published.
