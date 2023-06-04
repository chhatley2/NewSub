resource "azurerm_route_table" "routetable" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false

  route {
    name                   = "All-to-Hub"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "172.18.0.68"
  }
}

resource "azurerm_subnet_route_table_association" "routetable" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.routetable.id
}
