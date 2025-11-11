variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "primary_location" {
  description = "The primary location for the resources"
  type = string
  default = "central india"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
}
