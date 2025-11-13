variable "name" {
  description = "The name of the Key Vault. Must be globally unique."
  type        = string
}

variable "location" {
  description = "Azure region where the Key Vault will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group containing the Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Azure Active Directory tenant ID that should be used for Key Vault access."
  type        = string
}

variable "sku_name" {
  description = "SKU of the Key Vault. Possible values: 'standard' or 'premium'."
  type        = string
  default     = "standard"  # ✅ standard is fine for most workloads
}

variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled for this Key Vault."
  type        = bool
  default     = true  # ✅ required for production-grade resilience
}

variable "soft_delete_retention_days" {
  description = "Soft delete data retention in days."
  type        = number
  default     = 90  # ✅ Azure recommends 90 days for compliance
}

variable "rbac_authorization_enabled" {
  description = "Enable role-based access control for this Key Vault."
  type        = bool
  default     = true  # ✅ use RBAC instead of access policies for cleaner management
}

