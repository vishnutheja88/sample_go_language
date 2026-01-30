# Envoy Proxy with Go Application

A complete setup demonstrating Envoy proxy configuration with a Go backend service, including monitoring with Prometheus and Grafana.

## Architecture

- **Envoy Proxy**: Load balancer and reverse proxy (port 8080)
- **Go Application**: Simple HTTP service (port 9090)
- **Prometheus**: Metrics collection (port 9090)
- **Grafana**: Metrics visualization (port 3000)

## Quick Start

```bash
# Start all services
make up

# Monitor services
make monitor
```

## Services & Ports

| Service | Port | Description |
|---------|------|-------------|
| Envoy (Main) | 8080 | Application traffic |
| Envoy (Admin) | 9901 | Admin interface |
| Envoy (Stats) | 9091 | Prometheus metrics |
| Go App | 9090 | Backend service |
| Prometheus | 9090 | Metrics collection |
| Grafana | 3000 | Dashboard (admin/admin) |

## Envoy Features

- **Load Balancing**: Round-robin to Go service
- **Circuit Breaker**: Connection limits and timeouts
- **Retry Policy**: 3 retries on 5xx errors
- **Custom Headers**: Service identification
- **Prometheus Metrics**: Dedicated stats endpoint

## Available Commands

```bash
# Development
make build          # Build Go binary
make run           # Build and run locally
make test          # Run tests

# Docker
make up            # Start all services
make down          # Stop services
make detach        # Start in background
make logs          # View logs
make monitor       # Start and show URLs

# Cleanup
make clean         # Remove build files
make prune         # Full cleanup
```

## Testing

```bash
# Test application
curl http://localhost:8080

# Check Envoy admin
curl http://localhost:9901/stats

# Prometheus metrics
curl http://localhost:9091/stats/prometheus
```

## Configuration Files

- `envoy.yaml` - Envoy proxy configuration
- `docker-compose.yaml` - Multi-service setup
- `prometheus.yaml` - Metrics collection config
- `makefile` - Build and deployment commands