variable "scope" {
  description = "The scope at which the role assignment applies."
  type        = string
}

variable "role_definition_name" {
  description = "The name of the built-in role to assign (e.g., 'Contributor', 'Key Vault Administrator')."
  type        = string
}

variable "principal_id" {
  description = "The object ID of the principal (user, group, or service principal)."
  type        = string
}
