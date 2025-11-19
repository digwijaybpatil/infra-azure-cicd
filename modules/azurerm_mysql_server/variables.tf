variable "mysql_server_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "sku_name" {
  type    = string
  default = "GP_Standard_D2ds_v4"
}

variable "msversion" {
  type    = string
  default = "8.0"
}

variable "backup_retention_days" {
  type    = number
  default = 7
}

variable "delegated_subnet_id" {
  type = string
}




