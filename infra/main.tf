resource "azurerm_graphdb_account" "gremlin" { 
  name                = "${var.project_name}-gremlin"
  location                  = azurerm_resource_group.main.location
  resource_group_name       = azurerm_resource_group.main.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  enable_automatic_failover = false

  consistency_policy {
    consistency_level       = "Session"
  }

  capabilities {
    name = "EnableGremlin"
  }

  geo_location {
    location          = azurerm_resource_group.main.location
    failover_priority = 0
  }

  tags = {
    service = "tinkerpop-gremlin"
    api     = "Apache TinkerPop"
    usage   = "Graph-based movie recommendation data"
  }

}

resource "azurerm_graphdb_database" "main" {
  name                = "moviesdb"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.gremlin.name
}

resource "azurerm_graphdb_graph" "movies" {
  name                = "movies"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.gremlin.name
  database_name       = azurerm_cosmosdb_gremlin_database.main.name

  partition_key_path = "/id"
  throughput          = 400

  # Notes for developers:
  # - This graph uses the Apache TinkerPop Gremlin model
  # - Gremlin.Net client will be used in the Repository layer
  # - Schema is aligned with Neo4j's "movies" recommendation dataset
}