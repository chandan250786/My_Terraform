resource "azurerm_network_interface" "todo-nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    public_ip_address_id = "/subscriptions/094a2568-5c97-4160-b925-919a82293a3f/resourceGroups/todo-rg/providers/Microsoft.Network/publicIPAddresses/todo-pip-frontend"
    name                          = "internal"
    subnet_id                     = "/subscriptions/094a2568-5c97-4160-b925-919a82293a3f/resourceGroups/todo-rg/providers/Microsoft.Network/virtualNetworks/todo-vnet/subnets/frontend"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd@#$"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.todo-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}