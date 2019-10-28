# DevOps setup

## Abstract

We need to prepare the infrastructure.
We use

- [gitea](https://gitea.io/en-us/)

in a `docker-compose` environment.

## Setup

### docker-compose

Setup environment

`~/assets/setup_env.sh`{{execute}}

### Gitea

In the former script a git user was created.
To receive the name use

`git config --global user.name`{{execute}}

with the **password: secret**.

To access [Gitea](https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com/)
click on the **gitea** tab in the console.

Click login and use the username and password.
As you can see there is alread a repository created.
That one is cloned into the _git/foo_ folder.
All this was done in the setup script.
