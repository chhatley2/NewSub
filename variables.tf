#################################
# Global Configuration
#################################

variable "sub_name" {
  description = "Friendly Name of the New Subscription. No more than 8 characters. All CAPS"
  type        = string
  default     = "SANDBOX"
}

variable "environment" {
  description = "Should be either Prod or NonProd. All CAPS"
  type        = string
  default     = "NonProd"
}

variable "location" {
  description = "Default location of deployment. GAO's primary data center is EastUS. GAO's secondary data center is WestUS."
  type        = string
  default     = "EastUS"
}

variable "address_space" {
  description = "Address space of the entire vNet that will support subnet resources."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "Default DNS server for vNet. This should point to Azure-hosted domain controllers."
  type        = list(string)
  default     = ["172.18.3.4"]
}

variable "mgmt_subnet_address_prefix" {
  description = "Address prefix for the default management subnet must fall within the scope of address_space for vNet."
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "privatelink_keyvault_azure_net_zone_id" {
 description = "Specifies the location for the resource group and all the resources"
 default     =["/subscriptions/9ef01cbe-b3bb-4d98-a3cd-79b21d728191/resourceGroups/rg-hub-dns-prod-001/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"]
 type        = list(string)
}


