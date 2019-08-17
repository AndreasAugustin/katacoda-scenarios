#!/usr/bin/env bash

#####################
# Variables
#####################
DIR=$(dirname "$0")
ROOT_DIR="${DIR}/.."
GIT_DIR="${ROOT_DIR}/git"
DOCKER_COMPOSE_CMD="docker-compose -f ${DIR}/docker-compose.yml"
SET_GIT_USERNAME=$(git config --global user.name)
SET_GIT_EMAIL=$(git config --global user.email)
USERNAME="${SET_GIT_USERNAME:-john.doe}"
EMAIL="${SET_GIT_EMAIL:-john.doe@random.me}"
PASSWORD=secret
GITEA_URL="http://localhost:30002"
VERDACCIO_URL="http://localhost:30001"
REPO_NAME="npm-lerna"

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

# HACK: Wait for user creation finish. Else possible race condition.
sleep 2

${DOCKER_COMPOSE_CMD} exec -u git gitea gitea admin create-user --name="${USERNAME}" --password="${PASSWORD}" --email "${EMAIL}"

# HACK: Wait for user creation finish. Else possible race condition.
sleep 5

curl -X POST \
    "${GITEA_URL}/api/v1/user/repos" \
    -H "accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{ \"auto_init\": true, \"description\": \"Lerna tutorial\", \"gitignores\": \"Node\", \"license\": \"MIT\", \"name\": \"${REPO_NAME}\", \"private\": false, \"readme\": \"Default\"}" \
    -u "${USERNAME}:${PASSWORD}"

# init local repo
mkdir -p "${GIT_DIR}"
pushd "${GIT_DIR}" || exit
git clone "${GITEA_URL}/${USERNAME}/${REPO_NAME}.git"
popd || exit

# Prepare verdaccio
echo "--------------------- prepare verdaccio environment"
npm install -g npm-cli-adduser

export NPM_USER=${USERNAME}
export NPM_PASS=${PASSWORD}
export NPM_EMAIL=${EMAIL}
npx npm-cli-adduser --registry ${VERDACCIO_URL}
