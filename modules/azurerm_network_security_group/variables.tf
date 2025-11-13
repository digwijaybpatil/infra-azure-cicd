variable "nsg_name" {
  type = string
  description = "name of the nsg"
}

variable "location" {
  type = string
  description = "location of the nsg where nsg will be created"
}

variable "resource_group_name" {
  type = string
  description = "resource group name where nsg will be created"
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "list of security rules to be created in nsg"
}