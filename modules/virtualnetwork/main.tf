resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
}

variable "name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "address_space" {
  type        = list(string)
}

variable "dns_servers " {
  type        = list(string)
}
