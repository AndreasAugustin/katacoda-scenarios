# Git - crypt

## Abstract

[Git crypt](https://github.com/AGWA/git-crypt) helps you to handle secrets within your git repository.

- No accidentally push credentials
- Share credentials
- Put credentials into version control

## Installation

See [INSTALL.md](https://github.com/AGWA/git-crypt/blob/master/INSTALL.md) for installation instructions.
We are using `make` in this tutorial

```bash
pushd ~/git/
git clone git@github.com:AGWA/git-crypt.git
cd git-crypt
make
make install
popd
rm -rf ~/git-crypt/
```{{execute}}

## Setup

### GPG

We need a key-pair (maybe in reality it is already created for your mail adress)
Use the mail adress which is added to your git user

`git config --global --user.email`{{execute}}

`gpg --full-generate-key`{{execute}}

### Setup git-crypt 

In the setup step we already created a git repository `~/git/foo`
First change into the directory

`cd ~/git/foo/`{{execute}}

Now we need to init `git-crypt`

`git-crypt init`{{execute}}

Specify files to encrypt by creating a .gitattributes file:

```bash
secretfile filter=git-crypt diff=git-crypt
*.key filter=git-crypt diff=git-crypt
```

Now we add our git user to the secrets. Therefore we need to get the id of our gpg key.

```bash
gpg --list-keys <email-address>
```

Or just click

`gpg --list-key $(git config --global user.email)`{{execute}}

now we add the key to the keyring

```bash
# Need to execute this command
git-crypt add-gpg-user <USER_ID>
```

Now we add a file for encryption.

`echo "This file will be encrypted" >> ~/git/foo/to_encrypt.key`{{execute}}

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
