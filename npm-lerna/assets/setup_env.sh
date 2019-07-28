#!/usr/bin/env bash

# extract bash dir
DIR=$(dirname "$0")
DOCKER_COMPOSE_CMD="docker-compose -f ${DIR}/docker-compose.yml"
${DOCKER_COMPOSE_CMD} up -d

# add gitea user with gitea cli
# ${DOCKER_COMPOSE_CMD} exec gitea gitea admin create-user --name=my-user --password=secret --email my-user@tmp.org
