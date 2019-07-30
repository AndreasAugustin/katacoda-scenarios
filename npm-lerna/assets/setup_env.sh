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
GITEA_URL="http://localhost:30002"

echo "username set to: ${USERNAME}"
echo "email set to: ${EMAIL}"

#####################
#   Comands
#####################
echo "-------------- starting docker container"
#${DOCKER_COMPOSE_CMD} up -d

# Prepare git
echo "-------------- prepare git"

git config --global --replace-all user.name "${USERNAME}"
git config --global --replace-all user.email "${EMAIL}"

# Prepare Gitea
echo "-------------- prepare gitea environment"

#${DOCKER_COMPOSE_CMD} exec -u git gitea gitea admin create-user --name="${USERNAME}" --password="${PASSWORD}" --email "${EMAIL}"

curl -X POST \
    "${GITEA_URL}/api/v1/user/repos" \
    -H "accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{ \"auto_init\": true, \"description\": \"Lerna tutorial\", \"gitignores\": \"Node\", \"license\": \"MIT\", \"name\": \"npm-lerna\", \"private\": false, \"readme\": \"Default\"}" \
    -u "${USERNAME}:${PASSWORD}"

# init local repo
mkdir -p "${GIT_DIR}"
pushd "${GIT_DIR}" || exit
git clone "${GITEA_URL}/${USERNAME}"/npm-lerna.git
popd || exit
