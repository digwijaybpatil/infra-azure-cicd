variable "name" {
  type        = string
  description = "The name of the bastion host"
}

variable "location" {
  type       = string
  description = "The location of the bastion host"
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group where bastion host present"
}

variable "ip_configuration_name" {
  type        = string
  description = "The name of the IP configuration"
  default     = "bastion-ipconfig"
}

variable "subnet_id" {
  type = string
    description = "The ID of the subnet to deploy the bastion host into"
}

variable "public_ip_address_id" {
  type = string
  description = "public ip address attached to the bastion host"
}