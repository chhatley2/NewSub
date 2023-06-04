#################################
# Global Configuration
#################################

variable "sub_name" {
  description = "Friendly Name of the New Subscription. No more than 8 characters. All CAPS"
  type        = string
  default     = "SANDBOX"
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
  description = "Address prefix for the default management subnet. ."
  type        = string
  default     = "10.0.0.0/24"
}



