# Movies Microservice Demo

This repository is a hands-on demo of a cloud-native microservice solution built with [.NET Aspire](https://learn.microsoft.com/en-us/dotnet/aspire/), targeting Azure Container Apps (ACA). The backend uses Cosmos DB Gremlin (with the Neo4j "movies" dataset), and exposes both REST and GraphQL endpoints. It follows Clean Architecture and DDD principles, with modern CI/CD and IaC.

## Key Features
- Orchestrated by .NET Aspire (AppHost)
- Containerized for Azure Container Apps
- REST + GraphQL endpoints (Movies.Service)
- Data in Cosmos DB (Gremlin API), seeded from Neo4j
- Auth via Microsoft Entra ID
- Observability with Aspire + OpenTelemetry → Azure Monitor
- Terraform for all Azure IaC
- DevContainer and VS Code ready

## Solution Folder Structure

| Folder                   | Purpose                                                                                  |
|--------------------------|------------------------------------------------------------------------------------------|
| `src/Movies.AppHost`           | Aspire orchestrator (entry point for orchestrating and running services)            |
| `src/Movies.ServiceDefaults`   | Aspire shared configuration and defaults (cross-cutting concerns, e.g., logging, OTel) |
| `src/Movies.Service`           | Main microservice: REST & GraphQL API project (add manually if not present)         |
| `infra/`                       | Infrastructure as Code (Terraform, scripts)                                         |
| `docs/`                        | All markdown documentation and diagrams (draw.io/png)                               |
| `tests/`                       | Unit/integration test projects                                                      |
| `data/`                        | Data imports (e.g., Neo4j dump file, not included in git)                           |
| `.devcontainer/`               | VS Code Dev Container configuration (optional, for containerized dev)               |


## Quick Start

1. **Clone this repo:**
   ```sh
   git clone https://your-repo-url.git C:\repo\Movies
   cd C:\repo\Movies
