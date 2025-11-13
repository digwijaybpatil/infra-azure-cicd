output "nic_id" {
  description = "ID of the created network interface"
  value       = azurerm_network_interface.nic.id
}

output "nic_name" {
  description = "Name of the created network interface"
  value       = azurerm_network_interface.nic.name
}

output "nic_private_ip" {
  description = "Private IP address assigned to the NIC"
  value       = azurerm_network_interface.nic.private_ip_address
}