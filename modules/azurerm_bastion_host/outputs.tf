output "bastion_host_id" {
  description = "The ID of the Bastion host"
  value       = azurerm_bastion_host.bastion_host.id
}

output "bastion_host_name" {
  description = "The name of the Bastion host"
  value       = azurerm_bastion_host.bastion_host.name
}
