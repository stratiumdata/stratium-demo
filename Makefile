# Stratium Platform (Demo)

.PHONY: docker-build docker-up docker-down

# Default target
help:
	@echo "Stratium Platform (Demo)"
	@echo "  quickstart      - Runs docker-down followed by docker-up"
	@echo "  docker-up       - Start all services in customer mode"
	@echo "  docker-down     - Stop customer services"
	@echo "  docker-clean    - Performs a docker-down and also removes docker volumes"

# Quick start
quickstart: docker-down docker-up
	@echo "✓ Quickstart complete!"
	@echo ""
	@echo "Waiting for services to be healthy..."
	@sleep 5
	@echo ""
	@echo "You can now utilize the system!"
	@echo "  https://stratium.dev/docs - Golang CLI Client"

# Docker commands
docker-up:
	@echo "Starting all services with Docker Compose..."
	docker-compose -f docker-compose.yml up -d
	@echo "Services started!"
	@echo ""
	@echo "Enabling HTTPS on Keycloak"
	docker exec stratium-keycloak /opt/keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE --server http://localhost:8080 --realm master --user admin --password admin
	@echo ""
	@echo "Services available at:"
	@echo "  Platform:     localhost:50051 (gRPC)"
	@echo "  Key Manager:  localhost:50052 (gRPC)"
	@echo "  Key Access:   localhost:50053 (gRPC)"
	@echo "  Keycloak:     http://localhost:8080"
	@echo "  PostgreSQL:   localhost:5432"

docker-down:
	@echo "Stopping all services..."
	docker-compose -f docker-compose.yml down
	@echo "Services stopped!"

docker-clean:
	@echo "Cleaning volumes"
	docker-compose -f docker-compose.yml down -v
	@echo "Volumes removed!"