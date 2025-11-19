variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "primary_location" {
  description = "The primary location for the resources"
  type        = string
  default     = "central india"
}

variable "secondary_location" {
  type        = string
  description = "secondary location"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = string

}

variable "vms" {
  type = map(object({
    vm_size           = string
    vm_admin_username = string
    subnet_name       = string
    public_ip_enabled = optional(bool, false)
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    os_disk = object({
      caching              = string
      storage_account_type = string
      disk_size_gb         = optional(number)
    })
    security_rules = list(object({
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
  }))

}

# variable "vm_size" {
#   type        = string
#   description = "name of the vm"
# }

# variable "vm_admin_username" {
#   type        = string
#   description = "admin user name for vm"
# }

# variable "source_image_reference" {
#   description = "Source image reference"
#   type = object({
#     publisher = string
#     offer     = string
#     sku       = string
#     version   = string
#   })
# }

# variable "os_disk" {
#   description = "OS disk configuration"
#   type = object({
#     caching              = string
#     storage_account_type = string
#     disk_size_gb         = optional(number)
#   })
# }


# variable "security_rules" {
#   type = list(object({
#     name                       = string
#     priority                   = number
#     direction                  = string
#     access                     = string
#     protocol                   = string
#     source_port_range          = string
#     destination_port_range     = string
#     source_address_prefix      = string
#     destination_address_prefix = string
#   }))
#   description = "list of security rules to be created in nsg"
# }


variable "sql_servers" {
  type = map(object({
    sql_server_name          = string
    sql_admin_username       = string
    sql_password_secret_name = string
    server_version           = optional(string)
    minimum_tls_version      = optional(string)
  }))
}

variable "sql_databases" {
  type = map(object({
    database_name = string
    server_key    = string
    sku_name      = optional(string)
    max_size_gb   = optional(number)
    collation     = optional(string)
  }))
}


variable "mysql_servers" {
  type = map(object({
    mysql_server_name    = string
    admin_username       = string
    password_secret_name = string

    sku_name              = optional(string, "GP_Standard_D2ds_v4")
    version               = optional(string, "8.0")
    backup_retention_days = optional(number, 7)
  }))
}

variable "mysql_databases" {
  type = map(object({
    database_name = string
    server_key    = string # key of mysql_server map
  }))
}
