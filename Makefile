.PHONY: up
up:
	@docker compose up -d --build --force-recreate backend frontend

.PHONY: down
down:
	@echo "๐งน  Cleaning up development environment..."
	@docker compose down

.PHONY: logs
logs:
	@echo "๐  Viewing logs..."
	@docker compose logs -f

.PHONY: buf
buf:
	@docker compose run --rm app "buf generate"
