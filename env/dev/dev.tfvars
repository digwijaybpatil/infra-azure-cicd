environment = "dev"

vnet_address_space = "10.40.0.0/22"

vms = {
  app-vm = {
    vm_size           = "Standard_B1s"
    vm_admin_username = "azureuser"
    subnet_name       = "app"
    public_ip_enabled = true
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    security_rules = [
      {
        name                       = "Allow-SSH-From-My-IP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-VNet"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      }
    ]
  }

  web-vm = {
    vm_size           = "Standard_B1s"
    vm_admin_username = "azureuser"
    subnet_name       = "web"
    public_ip_enabled = true
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    security_rules = [
      {
        name                       = "Allow-SSH-From-My-IP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-VNet"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      }
    ]
  }
}

# vm_admin_username = "azureuser"
# vm_size           = "Standard_B1s"
# os_disk = {
#   caching              = "ReadWrite"
#   storage_account_type = "Standard_LRS"
# }
# source_image_reference = {
#   publisher = "Canonical"
#   offer     = "0001-com-ubuntu-server-jammy"
#   sku       = "22_04-lts"
#   version   = "latest"
# }

# security_rules = [
#   {
#     name                       = "Allow-SSH-From-My-IP"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*" 
#     destination_address_prefix = "*"
#   },
#   {
#     name                       = "Allow-HTTP"
#     priority                   = 200
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   },
#   {
#     name                       = "Allow-VNet"
#     priority                   = 300
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "VirtualNetwork" 
#     destination_address_prefix = "VirtualNetwork"
#   }
# ]

sql_servers = {
  server1 = {
    sql_server_name          = "dbserver"
    sql_admin_username       = "sqladmin"
    sql_password_secret_name = "sql-admin-password"
    server_version           = "12.0"
    minimum_tls_version      = "1.2"
  }
}

sql_databases = {
  db1 = {
    database_name = "appdb"
    server_key    = "server1"
    sku_name      = "Basic"
    max_size_gb   = 2
  }
}
