#!/usr/bin/env bash

#####################
# Variables
#####################
DIR=$(dirname "$0")
ROOT_DIR="${DIR}/.."
GIT_DIR="${ROOT_DIR}/git"
DOCKER_COMPOSE_CMD="docker-compose -f ${DIR}/docker-compose.yml"
USERNAME=$(git config --global user.name) || "john.doe"
EMAIL=$(git config --global user.email) || "john.doe@random.me"
PASSWORD=secret

echo "username set to: ${USERNAME}"
echo "email set to: ${EMAIL}"

#####################
#   Comands
#####################
echo "-------------- starting docker container"
${DOCKER_COMPOSE_CMD} up -d

# Prepare git
echo "-------------- prepare git"

git config --global --replace-all user.name "${USERNAME}"
git config --global --replace-all user.email "${EMAIL}"

# Prepare Gitea
echo "-------------- prepare gitea environment"
# Little hack to install
${DOCKER_COMPOSE_CMD} exec -u git gitea gitea admin create-user --name="${USERNAME}" --password="${PASSWORD}" --email "${EMAIL}"
mkdir -p "${GIT_DIR}"

# touch README.md
pushd "${GIT_DIR}" || exit
# git init
# git add README.md
# git commit -m "first commit"
# git remote add origin http://localhost:30002/my-user/tmp.git
# git push -u origin master
popd || exit
