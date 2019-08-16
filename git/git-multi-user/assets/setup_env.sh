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

${DOCKER_COMPOSE_CMD} exec -u git gitea-1 gitea admin create-user --name="${USERNAME1}" --password="${PASSWORD}" --email "${EMAIL1}"
${DOCKER_COMPOSE_CMD} exec -u git gitea-2 gitea admin create-user --name="${USERNAME2}" --password="${PASSWORD}" --email "${EMAIL2}"
