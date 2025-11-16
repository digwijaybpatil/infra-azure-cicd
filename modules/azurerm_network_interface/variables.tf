variable "name" {
  description = "Name of the network interface"
  type        = string
}

variable "location" {
  description = "Azure region where the NIC will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the NIC will be deployed"
  type        = string
}

variable "ip_configuration_name" {
  description = "Name for the NIC's IP configuration"
  type        = string
  default     = "ipconfig1"  
}

variable "private_ip_address_allocation" {
  description = "Private IP allocation type (Dynamic or Static)"
  type        = string
  default     = "Dynamic"  
}

variable "public_ip_address_id" {
  description = "Optional public IP association"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID to associate with this NIC"
  type        = string
}
