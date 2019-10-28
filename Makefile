SHELL := /bin/bash
.DEFAULT_GOAL := help

###########################
# VARIABLES
###########################
BUILD_ENV := NONE

###########################
# MAPPINGS
###########################

DOCKER_COMPOSE_NONE :=
DOCKER_COMPOSE_COMPOSE := docker-compose run dev

DOCKER_COMPOSE := $(DOCKER_COMPOSE_$(BUILD_ENV))
###########################
# TARGETS
###########################

.PHONY: help
help:  ## help target to show available commands with information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: information
information:  ## echo some build information
	@echo 'set build env to $(BUILD_ENV) and DOCKER_COMPOSE to $(DOCKER_COMPOSE)'
	@echo 'use make -e BUILD_ENV=COMPOSE <target> for using docker-compose build environment' 

.PHONY: validate
validate: information ## Validate the katacoda scenarios
	$(DOCKER_COMPOSE) npx katacoda validate:all --repo=./tsdevops/
	$(DOCKER_COMPOSE) npx katacoda validate:all --repo=./git/

.PHONY: markdownlint
markdownlint: information ## Validate markdown files
	$(DOCKER_COMPOSE) npx markdownlint .github/ --ignore node_modules
	$(DOCKER_COMPOSE) npx markdownlint . --ignore node_modules

.PHONY: bootstrap
bootstrap: ## Build Container
	@if [ $(BUILD_ENV) = "COMPOSE" ]; then\
        docker-compose build;\
    fi
	$(DOCKER_COMPOSE) npm ci

.PHONY: shell
shell: ## Open shell with dev dependencies installed in zsh
	docker-compose run dev zsh
