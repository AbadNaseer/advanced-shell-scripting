# Docker Makefile Automation

.PHONY: build up up-dev stop down logs restart test clean help

build: ## Build all Docker services
	docker-compose build

up: ## Start services in background
	docker-compose up -d

up-dev: ## Start services with logs
	docker-compose up

stop: ## Stop services
	docker-compose stop

down: ## Stop and remove everything
	docker-compose down -v --remove-orphans

logs: ## Show live logs
	docker-compose logs -f

restart: ## Restart services
	docker-compose restart

test: ## Placeholder for running tests
	@echo "No tests defined yet."

clean: ## Clean unused Docker resources
	docker system prune -af --volumes

help: ## Show available commands
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
