terraform {
 required_providers {
  azurerm = {
  source  = "hashicorp/azurerm"
  version = "3.43.0"
  }
 }
########################################################
## Update storage account name @@@@@@@@@@@@@@###########
########################################################
 backend "azurerm" {
  resource_group_name  = "RG-ALZ-DEVOPS-PROD-001"
  storage_account_name = "terrastate001"
  container_name       = "terraform"
  key                  = "coreinfra.tfstate"
 }
}

provider "azurerm" {
 # Configuration options
 features {}
}

data "azurerm_client_config" "current" {
}

########################################################
## Create New Subscription's Resource Groups ###########
########################################################
resource "azurerm_resource_group" "mgmtrg" {
  location = var.location
  name     = "RG-${var.sub_name}-MGMT-001"
}

resource "azurerm_resource_group" "vnetrg" {
  location = var.location
  name     = "RG-${var.sub_name}-VNET-001"
}


########################################################
## Virtual Network #####################################
########################################################
module "network" {
    source = "./modules/virtualnetwork"
    
    name = "VNET-${var.sub_name}-001"
    location            = azurerm_resource_group.vnetrg.location
    resource_group_name = azurerm_resource_group.vnetrg.id
    address_space       = [var.address_space]
    dns_servers         = [var.dns_servers]
}

########################################################
## MGMT Subnet##########################################
########################################################
module "mgmtsubnet" {
    source = "./modules/subnet"

    name                 = "SUB-${var.sub_name}-MGMT-001"
    location             = azurerm_resource_group.vnetrg.location
    resource_group_name  = azurerm_resource_group.vnetrg.id
    address_prefix       = var.mgmt_subnet_address_prefix
    virtual_network_name = module.network.azurerm_virtual_network.vnet.name
}

########################################################
## Default MGMT Subnet Network Security Group ##########
########################################################
module "mgmtnsg" {
    source = "./modules/nsg"
    
    name                = "NSG-${var.sub_name}-MGMT-001"
    location            = azurerm_resource_group.vnetrg.location
    resource_group_name = azurerm_resource_group.vnetrg.id
    subnet_id           = module.mgmtsubnet.azurerm_subnet.subnet.id
    address_prefix      = var.mgmt_subnet_address_prefix
}

########################################################
## Default MGMT Subnet Route Table #####################
########################################################
module "mgmtroute_table" {
    source = "./modules/routetable"
    
    name                = "RT-${var.sub_name}-MGMT-001"
    location            = azurerm_resource_group.vnetrg.location
    resource_group_name = azurerm_resource_group.vnetrg.id
    subnet_id           = module.mgmtsubnet.azurerm_subnet.subnet.id
}

########################################################
## Recovery Services Vault #############################
########################################################
module "backup" {
    source = "./modules/backup"
    
    name                 = "BUR-${var.sub_name}-${var.environment}-001"
    location             = azurerm_resource_group.mgmtrg.location
    resource_group_name  = azurerm_resource_group.mgmtrg.id
}

########################################################
## Key Vault ###########################################
########################################################
module "keyvault" {
    source = "./modules/keyvault"
    
    name                 = "SUB-${var.sub_name}-KV-${var.environment}-001"
    location             = azurerm_resource_group.mgmtrg.location
    resource_group_name  = azurerm_resource_group.mgmtrg.id
    subnet_id            = module.mgmtsubnet.azurerm_subnet.subnet.id
    private_dns_zone_ids = var.privatelink_keyvault_azure_net_zone_id
}