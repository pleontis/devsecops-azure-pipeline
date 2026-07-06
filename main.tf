provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "vulnerable-rg"
  location = "East US"
}

resource "azurerm_storage_account" "vulnerable_storage" {
  name                     = "vulnstorageacct12345"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # VULNERABILITY 1: Allows HTTP traffic (Secure transfer disabled)
  enable_https_traffic_only = false

  # VULNERABILITY 2: Allows outdated and vulnerable TLS 1.0
  min_tls_version = "TLS1_0"

  # VULNERABILITY 3: Allows public network access to the storage account
  public_network_access_enabled = true
}