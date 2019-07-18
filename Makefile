SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: help
help:  ## help target to show available commands with information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: validate
validate:  docker-build ## Validate the katacoda scenarios
	docker-compose run katacoda katacoda validate-all

.PHONY: markdownlint
markdownlint: docker-build ## Validate markdown files
	docker-compose run node markdownlint docs/
	docker-compose run node markdownlint .github/
	docker-compose run node markdownlint npm-lerna/

.PHONY: docker-build
docker-build: ## Build Container
	docker-compose build

.PHONY: bash-katacoda
bash-katacoda: docker-build ## Open bash with katacoda cli installed
	docker-compose run katacoda bash

.PHONY: bash-node
bash-node: docker-build ## Open bash with katacoda cli installed
	docker-compose run node bash
