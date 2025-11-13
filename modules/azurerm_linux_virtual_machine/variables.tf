variable "vm_name" {
  type = string
  description = "This is the name of the vm"
}

variable "resource_group_name" {
  type = string
  description = "This is the name of the resource group where vm will be created"
}

variable "location" {
  type =string
  description = "The location of the vm"
}

variable "vm_size" {
  type = string
  description = "The size of the vm"
  default = "Standard_B1s"
}

variable "admin_username" {
  type = string
  description = "admin username for the vm"
}

variable "network_interface_id" {
  type = string
  description = "network inteface id which will be assigned to vm"
}

variable "ssh_public_key" {
  type = string
  description = "This is the public key which will be stored at vm"
}

variable "disable_password_authentication" {
  type = bool
  default = true
}

variable "source_image_reference" {
  description = "Map defining the source image for the Linux VM."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "os_disk" {
  description = "OS Disk configuration"
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = optional(number)
  })
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = null
  }
}