help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

up: ## Down docker services
	docker compose up -d --build --force-recreate --pull always --wait --wait-timeout 90

down: ## Up docker services
	docker compose down --remove-orphans
