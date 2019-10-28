# Git - crypt

## Abstract

[Git crypt](https://github.com/AGWA/git-crypt) helps you to handle secrets within your git repository.

- No accidentally push credentials
- Share credentials
- Put credentials into version control

## Installation

See [INSTALL.md](https://github.com/AGWA/git-crypt/blob/master/INSTALL.md) for installation instructions.
We are using `make` in this tutorial

`apt update && apt install git-crypt`{{execute}}

## Setup

### GPG

We need a key-pair (maybe in reality it is already created for your mail adress)
Use the mail adress which is added to your git user

`git config --global user.email`{{execute}}
`git config --global user.name`{{execute}}

`gpg --gen-key`{{execute}}

### git-crypt

In the setup step we already created a git repository `~/git/foo`
First change into the directory

`cd ~/git/foo/`{{execute}}

Now we need to init `git-crypt`

`git-crypt init`{{execute}}

Specify files to encrypt by creating a .gitattributes file:

```bash
echo "secretfile filter=git-crypt diff=git-crypt\n*.key filter=git-crypt diff=git-crypt" > ~/git/foo/.gitattributes
```

Now we add our git user to the secrets. Therefore we need to get the id of our gpg key.

```bash
gpg --list-keys <email-address>
```

Or just click

`gpg --list-key $(git config --global user.email)`{{execute}}

(The id is at pub between / and the date)

now we add the key to the keyring

```bash
# Need to execute this command
git-crypt add-gpg-user <USER_ID>
```

Now we add a file for encryption.

`echo "This file will be encrypted" >> ~/git/foo/to_encrypt.key`{{execute}}

and commit our changes

```bash
pushd .
cd ~/git/foo/
git add .
git commit -m "add file to encrypt"
popd
```{{execute}}

```bash
pushd .
cd ~/git/foo/
git-crypt lock
popd
```{{execute}}

just check the file

`cat ~/git/foo/to_encrypt.key`{{execute}}

it is encrypted. For unlocking type

```bash
pushd .
cd ~/git/foo/
git-crypt unlock
popd
```{{execute}}

Check the file again

`cat ~/git/foo/to_encrypt.key`{{execute}}

The nice thing is that it is not possible to push the unencrypted file to git repo

```bash
pushd .
cd ~/git/foo/
git add .
git commit -m "add encrypted file"
git push
popd
```{{execute}}

Check the file in [Gitea](https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com/)
You can see that it is encrypted.

### Add users to git-crypt database

To add a user to git-crypt you need the public gpg file.
Just tell the other users to use the following command

```bash
gpg --armor --output public-key.gpg --export <key_mail_address>
```

Import the key file into your keyring and add trust level ultimate

```bash
gpg --import public-key.gpg
# get the id of the imported key
gpg --list-key <key_mail_address>
gpg --edit-key <key_id>
trust
# We need ultimate trust, so choose 5
save
```

now you are able to add the user as before with

```bash
# the user_id is the id of the user in your public key_ring
git-crypt add-gpg-user <USER_ID>
```
