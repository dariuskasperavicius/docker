.PHONY: default
default: help


.PHONY: help
help: ## Get this help.
	@echo Tasks:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

FORCE:

.PHONY:
build:
	@cd docker && \
	docker-compose build && \
	docker-compose up -d php mysql && \
	docker-compose exec php bash build.sh && \
	docker-compose down


.PHONY:
run: ## Start docker containers
	@cd docker && \
	docker-compose up -d || (echo "Run failed? Try building first" && exit 1)

.PHONY:
stop: ## Stop docker containers
	@cd docker && docker-compose down

.PHONY:
ssh: ## Connect to docker containers
	@cd docker && docker-compose exec php bash

redis:
	@cd docker && docker-compose exec redis redis-cli

test:
	@cd docker && docker-compose exec php bash run_tests.sh