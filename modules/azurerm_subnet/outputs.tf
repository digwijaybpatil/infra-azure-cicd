output "snet_id" {
    value       = azurerm_subnet.snet.id
    description = "The ID of the subnet"  
}

output "snet_name" {
  description = "The name of the subnet"
  value       = azurerm_subnet.snet.name
}

output "snet_address_prefixes" {
  description = "The address prefixes of the subnet"
  value       = azurerm_subnet.snet.address_prefixes
}