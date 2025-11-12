variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "primary_location" {
  description = "The primary location for the resources"
  type        = string
  default     = "central india"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = string

}

variable "vm_size" {
  type        = string
  description = "name of the vm"
}

variable "vm_admin_username" {
  type        = string
  description = "admin user name for vm"
}

variable "source_image_reference" {
  description = "Source image reference"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "os_disk" {
  description = "OS disk configuration"
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
}




