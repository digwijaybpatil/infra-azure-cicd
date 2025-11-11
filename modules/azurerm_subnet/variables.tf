variable "name" {
  type        = string
  description = "name of the subnet"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "address_prefixes" {
  type        = list(string)
  description = "address_prefixes for snet"
}
