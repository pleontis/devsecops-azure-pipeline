# Remote Backend for State Locking and Security
terraform {
  backend "azurerm" {
    resource_group_name  = "devsecops-tfstate-rg"
    storage_account_name = "tfstate12345"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

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
  account_replication_type = "GRS"

  tags = {
    Environment = "Production"
    CostCenter  = "Dept-492"
  }

  # Core Security Enforcements
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  # --- RISK ACCEPTANCE / CHECKOV SKIPS ---
  # checkov:skip=CKV2_AZURE_1: "Accepting risk: CMK requires Key Vault deployment, which is out of scope."
  # checkov:skip=CKV2_AZURE_33: "Accepting risk: Private Endpoints require VNet infrastructure, out of scope."
  # checkov:skip=CKV_AZURE_33: "Accepting risk: Queue logging handled via central Azure Monitor settings."
  # checkov:skip=CKV2_AZURE_41: "Accepting risk: SAS policy unnecessary; Shared Access Keys disabled."
}