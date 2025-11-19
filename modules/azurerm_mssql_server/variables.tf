variable "sql_server_name" {
  type        = string
  description = "The SQL Server name. Must be globally unique."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the SQL Server will be created."
}

variable "server_location" {
  type        = string
  description = "Azure region for the SQL Server."
}

variable "server_version" {
  type        = string
  description = "SQL Server version."
  default     = "12.0"
}

variable "sql_admin_username" {
  type        = string
  description = "Admin username for SQL Server."
}

variable "sql_admin_password" {
  type        = string
  description = "Admin password for SQL Server. Pass via Key Vault."
  sensitive   = true
}

variable "minimum_tls_version" {
  type        = string
  description = "Minimum TLS version required for connections."
  default     = "1.2"
}
