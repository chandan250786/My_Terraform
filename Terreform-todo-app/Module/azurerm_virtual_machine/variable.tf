variable "nic_name" {
  description = "The name of the network interface for the virtual machine."
  type        = string
}

variable "location" {
    description = "The name of the nlocation."
  type        = string  
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "The size of virtual machine."
  type        = string
}

variable "image_publisher" {
  type = string
}

variable "image_offer" {
  type = string
}

variable "image_sku" {
  type = string
}

variable "image_version" {
  type = string
}
