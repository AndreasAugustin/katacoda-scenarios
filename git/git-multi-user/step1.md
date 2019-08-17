# Git multi user

## Abstract

We want to have various git users and push to multi repositories.
For the scenario there are 2 different gitea server enabled.

## Setup environment

Run the following command for the setup
`~/assets/setup_env.sh`{{execute}}

- [Gitea 1](https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com/)
  - username: john.doe
  - email: john.doe@random.de
  - password: secret
- [Gitea 2](https://[[HOST_SUBDOMAIN]]-30002-[[KATACODA_HOST]].environments.katacoda.com/)
  - username: jane.doe
  - email: jane.doe@random.de
  - password: secret

Login with both users.

## Setup ssh keys

To access our repository we need to create 2 ssh key pairs

`ssh-keygen -t rsa -N "" -C "john.doe@random.de" -f '/root/.ssh/id_rsa_john_doe'`{{execute}}
`ssh-keygen -t rsa -N "" -C "jane.doe@random.de" -f '/root/.ssh/id_rsa_jane_doe'`{{execute}}

Add the public key content to related gitea account
`cat ~/.ssh/id_rsa_john_doe.pub`{{execute}}
`cat ~/.ssh/id_rsa_jane_doe.pub`{{execute}}

Also we need to configure which user to use for which git server.
`touch ~/.ssh/config`{{execute}}
Copy

```ssh
# gitea-1 john.doe
Host localhost:30001
  HostName localhost
  User git
  IdentityFile ~/.ssh/id_rsa_john_doe

# gitea-2 jane.doe
Host localhost:30002
  HostName localhost
  User git
  IdentityFile ~/.ssh/id_rsa_jane_doe
```

to **~/.ssh/config**

Now we are set to test the settings.
