variable "database_name" {
  type        = string
  description = "The name of the database."
}

variable "server_id" {
  type        = string
  description = "The ID of the MSSQL server where the database will be created."
}

variable "collation" {
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "max_size_gb" {
  type        = number
  default     = 2
}

variable "sku_name" {
  type        = string
  default     = "Basic"
}


