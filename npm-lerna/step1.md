# OPS setup

## Abstract

We need to prepare the infrastructure.
We use

- [gitea](https://gitea.io/en-us/)
- [verdaccio](https://github.com/verdaccio/verdaccio)

in a kubernetes environment. The services are already up and running.

## Setup

### Minikube

Kubernetes with minikube is used.
The **services** and **pods** files are located in [assets](assets/)
directory.
A simple bash script is prepared.
Execute `./assets/setup_env.sh`{{execute HOST1}}

This starts `minikube` and the services and pods.
The `minikube start` command takes some time, please be patient (max 1 minute).

### Gitea

To access [Gitea](https://[[HOST_SUBDOMAIN]]-30002-[[KATACODA_HOST]].environments.katacoda.com/)
click on the **gitea** tab in the console.

TODO:(anau) add OPS stuff setup documentation

![Gitea start screen](assets/gitea_start_screen.png)

### Verdaccio

To access [Verdaccio](https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com/)
click on the **verdaccio** tab in the console.

TODO:(anau) add OPS stuff setup documentation

![Verdaccio start screen](assets/verdaccio_start_screen.png)
