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
pushd .
git clone git@github.com:AGWA/git-crypt.git
cd git-crypt
make
make install
popd
rm -rf git-crypt
```{{execute}}

## Setup

First we need a new git repository

```bash
mkdir foo
cd foo
git init
echo "# Foo" >> README.md
git add .
git commit -m "initial commit"
```{{execute}}
