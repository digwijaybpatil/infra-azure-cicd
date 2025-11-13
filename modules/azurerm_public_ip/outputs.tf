output "pip_id" {
  value = azurerm_public_ip.pip.id
  description = "pip id"
}

output "public_ip_address" {
  description = "The actual IP address of the Public IP"
  value       = azurerm_public_ip.pip.ip_address
}

output "public_ip_name" {
  description = "The name of the Public IP resource"
  value       = azurerm_public_ip.pip.name
}