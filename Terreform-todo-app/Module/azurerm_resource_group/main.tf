resource "azurerm_resource_group" "rgs" {
    name = var.resource_group_name
    location = var.resource_group_location
}

