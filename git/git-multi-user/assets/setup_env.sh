#!/usr/bin/env bash

#####################
# Variables
#####################
DIR=$(dirname "$0")
DOCKER_COMPOSE_CMD="docker-compose -f ${DIR}/docker-compose.yml"
SET_GIT_USERNAME=$(git config --global user.name)
SET_GIT_EMAIL=$(git config --global user.email)
USERNAME1="${SET_GIT_USERNAME:-john.doe}"
EMAIL1="${SET_GIT_EMAIL:-john.doe@random.me}"
USERNAME2="${SET_GIT_USERNAME:-jane.doe}"
EMAIL2="${SET_GIT_EMAIL:-jane.doe@random.me}"
PASSWORD=secret
GITEA1_URL="http://localhost:30001"
GITEA2_URL="http://localhost:30002"
REPO1_NAME="john-repo"
REPO2_NAME="jane-repo"

echo "username1 set to: ${USERNAME1}"
echo "email1 set to: ${EMAIL1}"
echo "username2 set to: ${USERNAME2}"
echo "email2 set to: ${EMAIL2}"

#####################
#   Comands
#####################
echo "-------------- starting docker container"
${DOCKER_COMPOSE_CMD} up -d

# Prepare Gitea
echo "-------------- prepare gitea environment"
sleep 2

${DOCKER_COMPOSE_CMD} exec -u git gitea-1 gitea admin create-user --name="${USERNAME1}" --password="${PASSWORD}" --email "${EMAIL1}"

${DOCKER_COMPOSE_CMD} exec -u git gitea-2 gitea admin create-user --name="${USERNAME2}" --password="${PASSWORD}" --email "${EMAIL2}"

# HACK: Wait for user creation finish. Else possible race condition.
sleep 5

curl -X POST \
    "${GITEA1_URL}/api/v1/user/repos" \
    -H "accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{ \"auto_init\": true, \"description\": \"tutorial\", \"gitignores\": \"Node\", \"license\": \"MIT\", \"name\": \"${REPO1_NAME}\", \"private\": false, \"readme\": \"Default\"}" \
    -u "${USERNAME1}:${PASSWORD}"

curl -X POST \
    "${GITEA2_URL}/api/v1/user/repos" \
    -H "accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{ \"auto_init\": true, \"description\": \"tutorial\", \"gitignores\": \"Node\", \"license\": \"MIT\", \"name\": \"${REPO2_NAME}\", \"private\": false, \"readme\": \"Default\"}" \
    -u "${USERNAME2}:${PASSWORD}"
