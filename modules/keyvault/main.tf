resource "azurerm_key_vault" "keyvault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  enable_rbac_authorization = true
  enabled_for_template_deployment = true
  enabled_for_deployment = true
  public_network_access_enabled = false

  network_acls {
    default_action = "deny"
    bypass = "AzureServices"
  }
}

resource "azurerm_private_endpoint" "keyvault" {
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}Connection"
    private_connection_resource_id = azurerm_storage_account.keyvault.id
    is_manual_connection           = false
    subresource_names              = "vault"
  }
  
  private_dns_zone_group {
    name                 = "Default"
    private_dns_zone_ids = var.private_dns_zone_ids
  }
}