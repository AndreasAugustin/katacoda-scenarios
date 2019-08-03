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

TODO(anau): add content for npx lerna publish
