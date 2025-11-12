environment = "prod"

vnet_address_space = "10.39.0.0/22"

vm_admin_username = "azureuser"
vm_size           = "Standard_B1s"
os_disk = {
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
}
source_image_reference = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts"
  version   = "latest"
}
