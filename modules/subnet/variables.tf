variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "address_prefixes" {
  type = list(string)
}

variable "virtual_network_name" {
  type = string
}