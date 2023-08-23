help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

dotenv: ## Copy .env.example to .env
	rsync -q --ignore-existing ./.env.example ./.env

up: ## Up docker services
	docker compose up -d --build --force-recreate --pull always --wait --wait-timeout 150

down: ## Down docker services
	docker compose down --remove-orphans

logs: ## Show docker logs
	docker compose logs -ft
