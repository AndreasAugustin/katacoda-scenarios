# Lerna basics

Our project directory is `git/npm-lerna` so lets cd there

`cd ~/git/npm-lerna/`{{execute}}

Check

`pwd`{{execute}}

Should be reveal `/root/git/npm-lerna`.

Because we have a *npm* project we should create a `.gitignore`.

`echo node_modules/ > .gitignore`{{execute}}

First we want to init our npm project.

`npm init`{{execute}}

Because this is our project root we do not have a main *index.js*.
Delete this part in the *package.json*.

Now let's install and initialise
[lerna](
    https://github.com/lerna/lerna)

`npm i lerna -D`{{execute}}

`npx lerna init`{{execute}}

You get a `packages/` dir and a `lerna.json`

`cat lerna.json`{{execute}}

`ls packages/`{{execute}}

The packages folder is empty.

*Remark**

It is possible to create a project by cli.

```bash
# we use another way, do not execute
npx lerna create --registry http://localhost:30001 foo
```

Because we want to have a typescript package we choose another way.

`mkdir packages/foo`{{execute}}

`cd ~/git/npm-lerna/package/foo`{{execute}}

`npx gts init`{{execute}}

Because we want to use our *npm registry* and we want to publish a lib copy

```json
"directories": {
  "lib": "build",
  "test": "tests"
},
"publishConfig": {
  "registry": "http://localhost:30001"
}
```

to `package.json` before the **script tag**.

Now we have our first lerna project :rocket.

Becasue we want't to have a second repository we just copy this
one with small adjustments.

Go one directory up

`cd ~/git/npm-lerna/packages/`{{execute}}

`cp -R foo/ bar/`{{execute}}

Now we just need to change the package name in bar.

Change in both `package.json` the name to
*@nmp-lerrna/foo* and *@npm-lerna/bar*.

Now lets go to the lerna root.

`cd ~/git/npm-lerna/`{{execute}}

And check our packages.

`npx lerna list`{{execute}}

Now we can run our first script

`npx lerna run fix`{{execute}}

As you can see, lerna is running the script in both packages.

`npx lerna run check --stream`{{execute}}

for a stream output.

If you want to run a script in a single package use

`npx lerna run --scope @npm-lerna/foo check`{{execute}}

To save our process we should commit and push the stuff.

`cd ~/git/nom-lerna`{{execute}}

`git status`{{execute}}

`git add .`{{execute}}

`git commit -m "add 2 typescript lerna projects"`{{execute}}

`git push`{{execute}}

If you forgot your username:

`git config --global user.name`{{execute}}

and password: **secret**

Move to gitea to see the changes. Either click the
verdaccio tab in terminal or
[Verdaccio](
    https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com/)
