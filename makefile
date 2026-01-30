BINARY_NAME=myapp
GO_FILES=$(wildcard *.go)
VERSION=$(shell git rev-parse --short HEAD 2>/dev/null || echo "v0.1.2")
BUILD_DIR=bin
IMAGE_NAME=myapp-$(VERSION)

all: build

build:
	@echo "Building $(BINARY_NAME)..."
	@go build -ldflags "-X main.Version=$(VERSION)" -o $(BUILD_DIR)/$(BINARY_NAME) .
	@echo "Build complete: bin/$(BINARY_NAME)"

run: build
	@./bin/$(BINARY_NAME)
test:
	go test -v .
#test:
#	@echo "Building version $(VERSION)..."
#	go build -ldflags "-X main.Version=$(VERSION)" -o /bin/$(BINARY_NAME) .
setup:
	@if [ ! -f go.mod ]; then \
		echo "Initializing Go module..."; \
		go mod init myapp; \
	fi
	go mod tidy
clean:
	@echo "Cleaning up..."
	@rm -rf bin/
	@go clean
tindy:
	@go fmt ./..
	@go mod tidy

help:
	@echo "Available commands:"
	@echo " make buid - compile binary"
	@echo " make run - Build and run"
	@echo " meke test - Run Tests"
	@echo " make clean - Remove build files"

.PHONY: docker-build docker-run

docker-build:
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME) .

docker-run: docker-build
	@echo "Running Docker container..."
	docker run --rm $(IMAGE_NAME)

up:
	docker compose up --build
down:
	docker compose down

prune:
	docker compose down --rmi local
	rm -rf bin/
detach:
	docker compose up -d
logs:
	docker compose logs -f
monitor:
	docker compose up -d
	@echo "---- DASHBOARD STATUS ----"
	@echo "App/Envoy: http://localhost:8080"
	@echo "Prometheus: http://localhost:9090"
	@echo "Grafana: http://localhost:3000 (admin/admin)"