variable "name" {
    type        = string
    description = "The name of the virtual network"
}

variable "address_space" {
    type        = list(string)
    description = "The address space for the virtual network"
}

variable "location" {
    type        = string
    description = "The location for the virtual network"
}

variable "resource_group_name" {
    type        = string
    description = "The name of the resource group where the virtual network will be created"
}