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
GITEA_URL="http://localhost:30001"
REPO_NAME="foo"

# Prepare git
echo "-------------- prepare git"

git config --global --replace-all user.name "${USERNAME}"
git config --global --replace-all user.email "${EMAIL}"
git config --global push.default simple

#####################
#   Comands
#####################
echo "-------------- starting docker container"
${DOCKER_COMPOSE_CMD} up -d

# Prepare Gitea
echo "-------------- prepare gitea environment"
sleep 5

${DOCKER_COMPOSE_CMD} exec -u git gitea-1 gitea admin create-user --name="${USERNAME}" --password="${PASSWORD}" --email "${EMAIL}"

# HACK: Wait for user creation finish. Else possible race condition.
sleep 5

curl -X POST \
    "${GITEA_URL}/api/v1/user/repos" \
    -H "accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{ \"auto_init\": true, \"description\": \"tutorial\", \"gitignores\": \"Node\", \"license\": \"MIT\", \"name\": \"${REPO_NAME}\", \"private\": false, \"readme\": \"Default\"}" \
    -u "${USERNAME}:${PASSWORD}"

# init local repo
mkdir -p "${GIT_DIR}"
pushd "${GIT_DIR}" || exit
git clone "${GITEA_URL}/${USERNAME}/${REPO_NAME}.git"
popd || exit

echo "-------- done"
