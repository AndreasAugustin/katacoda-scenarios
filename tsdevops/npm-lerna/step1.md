# DevOps setup

## Abstract

We need to prepare the infrastructure.
We use

- [gitea](https://gitea.io/en-us/)
- [verdaccio](https://github.com/verdaccio/verdaccio)

in a `docker-compose` environment.

## Setup

### docker-compose

Setup environment

`~/assets/setup_env.sh`{{execute}}

### Gitea

In the former script a git user was created.
To receive the name use

`git config --global user.name`{{execute}}

with the **password: secret**

To access [Gitea](https://[[HOST_SUBDOMAIN]]-30002-[[KATACODA_HOST]].environments.katacoda.com/)
click on the **gitea** tab in the console.

![Gitea start screen](/andreasaugustin/courses/tsdevops/npm-lerna/assets/gitea_start_screen.png)

Click login and use the username and password.
As you can see there is alread a repository created.
That one is cloned into the _git/npm-lerna_ folder.
All this was done in the setup script.

### Verdaccio

To access [Verdaccio](https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com/)
click on the **verdaccio** tab in the console.

Also in the script a user has been created.
Use the same username and password as before.

![Verdaccio start screen](/andreasaugustin/courses/tsdevops/npm-lerna/assets/verdaccio_start_screen.png)

There is a _.npmrc_ created in _~/_.

`cat .npmrc`{{execute}}

For validating that we are logged in run

`npm whoami --registry http://localhost:30001`{{execute}}
