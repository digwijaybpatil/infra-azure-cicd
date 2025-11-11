variable "name" {
    type        = string
    description = "The name of the public IP"  
}

variable "location" {
    type        = string
    description = "The location for the public IP"    
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group where the public IP will be created"
}

variable "allocation_method" {
  type = string
  description = "The allocation method for the public IP (Static or Dynamic)"
}

variable "sku" {
  type = string
  description = "sku of the PIP"
}