.EXPORT_ALL_VARIABLES:

include .env

ifneq ("$(wildcard .env.local)","")
    include .env.local
endif

# Permissions
USER_UID=$(shell id -u)

# Makefile config
.DEFAULT_GOAL:=help
.PHONY: start debug stop enter rebuild help

## Docker
start: ## Build and start PHP workspace.
	@docker compose -f ./docker/compose.yaml -p ${PROJECT_NAME} up -d --build

debug: ## Build and start the PHP workspace with debugging enabled.
	@XDEBUG_MODE=debug docker compose -f ./docker/compose.yaml -p ${PROJECT_NAME} up -d --build

stop: ## Stop the PHP workspace.
	@docker compose -p ${PROJECT_NAME} down

enter: ## Enter the PHP workspace.
	@docker exec -it ${PROJECT_NAME}-php-1 /bin/bash || true

## Build
rebuild: ## Forces a rebuild of the custom Docker image.
	@docker compose -f ./docker/compose.yaml build --no-cache

## Help
help: ## Show available commands.
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' Makefile | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m##/' | sed -e 's/##//'
