module "resource_group_name" {
  source                  = "../Module/azurerm_resource_group"
  resource_group_name     = "todo-rg"
  resource_group_location = "centralindia"
}

module "virtual_network" {
  depends_on                     = [module.resource_group_name]
  source                         = "../Module/azurerm_virtual_network"
  virtual_network_name           = "todo-vnet"
  virtual_network_location       = "Centralindia"
  virtual_network_address_space  = ["10.0.0.0/16"]
  virtual_network_resource_group = "todo-rg"
}

module "frontend-subnet" {
  depends_on                  = [module.virtual_network]
  source                      = "../Module/azurerm_subnet"
  subnet_name                 = "frontend"
  subnet_resource_group_name  = "todo-rg"
  subnet_virtual_network_name = "todo-vnet"
  subnet_address_prefixes     = ["10.0.1.0/24"]
}

module "backend-subnet" {
  depends_on                  = [module.virtual_network]
  source                      = "../Module/azurerm_subnet"
  subnet_name                 = "backend"
  subnet_resource_group_name  = "todo-rg"
  subnet_virtual_network_name = "todo-vnet"
  subnet_address_prefixes     = ["10.0.2.0/24"]
}

module "public_ip_frontend" {
  source                      = "../Module/azurerm_public_ip"
  public_ip_name              = "todo-pip-frontend"
  public_ip_resource_group    = "todo-rg"
  public_ip_location          = "Centralindia"
  public_ip_allocation_method = "Static"
}


module "frontend_vm" {
  depends_on          = [module.frontend-subnet]
  source              = "../Module/azurerm_virtual_machine"
  nic_name            = "nic-vm-frontend"
  location            = "Centralindia"
  resource_group_name = "todo-rg"
  vm_name             = "frontend-vm"
  vm_size             = "Standard_B1s"
  image_publisher     = "Canonical"
  image_offer         = "0001-com-ubuntu-server-focal"
  image_sku           = "20_04-lts"
  image_version       = "latest"



}



















# module "public_ip_backend" {
#   source                      = "../Module/azurerm_public_ip"
#   public_ip_name              = "todo-pip-backend"
#   public_ip_resource_group    = "todo-rg"
#   public_ip_location          = "Centralindia"
#   public_ip_allocation_method = "Static"
# }

module "sql_server" {
  source                                  = "../Module/azurerm_sql_server"
  sql_server_name                         = "todosqlserver10011001"
  sql_server_resource_group               = "todo-rg"
  sql_server_location                     = "Centralindia"
  sql_server_administrator_login          = "sqladmin"
  sql_server_administrator_login_password = "P@ssw0rd@12#$"
}

module "sql_database" {
  depends_on       = [module.sql_server]
  source           = "../Module/azurerm_sql_database"
  sql_db_name      = "todo-db"
  sql_db_server_id = "/subscriptions/094a2568-5c97-4160-b925-919a82293a3f/resourceGroups/todo-rg/providers/Microsoft.Sql/servers/todosqlserver10011001"
}