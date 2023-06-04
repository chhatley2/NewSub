//////////NSG//////////

resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

//////////INBOUND RULES//////////

resource "azurerm_network_security_rule" "GAOHQIn" {
    name                        = "Allow-GAO-Networks-In"
    priority                    = 500
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefixes     = ["10.0.0.0/8", "192.168.0.0/16", "172.24.0.0/16", "172.25.0.0/16"]
    destination_address_prefix  = var.address_prefix
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "GAOAzureIn" {
    name                        = "Allow-Azure-Networks-In"
    priority                    = 600
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = var.address_prefix
    destination_address_prefix  = var.address_prefix
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.nsg.name
}

//////////OUTBOUND RULES//////////

resource "azurerm_network_security_rule" "InternetOut" {
    name                        = "Allow-Internet-Out"
    priority                    = 500
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = var.address_prefix
    destination_address_prefix  = "*"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "GAOAzureOut" {
    name                        = "Allow-Azure-Networks-Out"
    priority                    = 600
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = var.address_prefix
    destination_address_prefix  = var.address_prefix
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "GAOHQOut" {
    name                         = "Allow-GAO-Networks-Out"
    priority                     = 700
    direction                    = "Outbound"
    access                       = "Allow"
    protocol                     = "*"
    source_port_range            = "*"
    destination_port_range       = "*"
    source_address_prefix        = var.address_prefix
    destination_address_prefixes = ["10.0.0.0/8", "192.168.0.0/16", "172.24.0.0/16", "172.25.0.0/16"]
    resource_group_name          = var.resource_group_name
    network_security_group_name  = azurerm_network_security_group.nsg.name
}
