terraform {
 required_providers {
  azurerm = {
  source  = "hashicorp/azurerm"
  version = "3.43.0"
  }
 }
 backend "azurerm" {
  resource_group_name  = "RG-ALZ-DEVOPS-PROD-001"
  storage_account_name = "terrastate001"
  container_name       = "terraform"
  key                  = "${var.sub_name}.tfstate"
 }
}

provider "azurerm" {
 # Configuration options
 features {}
}

data "azurerm_client_config" "current" {
}

########################################################
## New Subscription's Virtual Network ##################
########################################################
module "network" {
    source = "./modules/virtualnetwork"
    
    name = "st${sub_name}tstate01"
    location = var.location
    resource_group_name = "RG-${sub_name}-VNET-001"
    address_space = [var.address_space]
    dns_servers = [var.dns_servers]
    subnet_name
}

########################################################
## New Subscription's Terraform State Stroage Account ##
########################################################
module "terrafrom_storage" {
    source = "./modules/storage"
    
    name = "st${sub_name}tstate01"
    location = var.location
    resource_group_name = "RG-${sub_name}-MGMT-001"
}
