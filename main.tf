provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "secure-rg"
  location = "East US"
}

resource "azurerm_storage_account" "secure_storage" {
  name                     = "securestorageacct12345"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # REMEDIATION 1: Enforce HTTPS only (Secure transfer required)
  enable_https_traffic_only = true

  # REMEDIATION 2: Enforce modern, secure TLS 1.2
  min_tls_version = "TLS1_2"

  # REMEDIATION 3: Block public network access
  public_network_access_enabled = false
}