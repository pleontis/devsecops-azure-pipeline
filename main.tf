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
  
  # REMEDIATION: CKV_AZURE_206 (Changed from LRS to Geo-Redundant Storage)
  account_replication_type = "GRS"

  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  # REMEDIATION: CKV_AZURE_190 & CKV2_AZURE_47 (Block anonymous blob access)
  allow_nested_items_to_be_public = false

  # REMEDIATION: CKV2_AZURE_40 (Disable legacy Shared Key authorization)
  shared_access_key_enabled = false

  # REMEDIATION: CKV2_AZURE_38 (Enable soft-delete for accidental deletion protection)
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  # --- RISK ACCEPTANCE / CHECKOV SKIPS ---

  # checkov:skip=CKV2_AZURE_1: "Accepting risk: Customer Managed Keys (CMK) require Key Vault deployment, which is out of scope for this pipeline demo."
  # checkov:skip=CKV2_AZURE_33: "Accepting risk: Private Endpoints require VNet infrastructure, which is out of scope for this demo."
  # checkov:skip=CKV_AZURE_33: "Accepting risk: Queue logging is handled via Azure Monitor Diagnostic Settings centrally, not locally."
  # checkov:skip=CKV2_AZURE_41: "Accepting risk: SAS expiration policy is unnecessary because Shared Access Keys are completely disabled above."
}