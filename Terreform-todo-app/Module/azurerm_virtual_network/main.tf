resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_name
  location            = var.virtual_network_location
  resource_group_name = var.virtual_network_resource_group
  address_space       = var.virtual_network_address_space
}

