variable "virtual_network_name" {
  type = string
}

variable "virtual_network_location" {
  type = string
}

variable "virtual_network_resource_group" {
  type = string
}

variable "virtual_network_address_space" {
  type = list(string)
  }