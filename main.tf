module "rg" {
  source   = "./modules/azurerm_resource_group"
  name     = "rg-${var.application_name}-${var.environment}"
  location = var.primary_location
}

module "vnet" {
  source              = "./modules/azurerm_virtual_network"
  name                = "vnet-${var.application_name}-${var.environment}"
  address_space       = [var.vnet_address_space]
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
}

locals {
  subnets = {
    AzureBastionSubnet = cidrsubnet(var.vnet_address_space, 4, 0)
    app                = cidrsubnet(var.vnet_address_space, 2, 1)
    data               = cidrsubnet(var.vnet_address_space, 2, 2)
    web                = cidrsubnet(var.vnet_address_space, 2, 3)
  }
}

module "snet" {
  source               = "./modules/azurerm_subnet"
  for_each             = local.subnets
  name                 = each.key
  virtual_network_name = module.vnet.vnet_name
  resource_group_name  = module.rg.resource_group_name
  address_prefixes     = [each.value]
}

module "pip_bastion" {
  source              = "./modules/azurerm_public_ip"
  name                = "pip-bastion-${var.application_name}-${var.environment}"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
}

module "pip_vm" {
  source              = "./modules/azurerm_public_ip"
  name                = "pip-vm-${var.application_name}-${var.environment}"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "nsg_vm" {
  source              = "./modules/azurerm_network_security_group"
  nsg_name            = "nsg-vm-${var.application_name}-${var.environment}"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  security_rules      = var.security_rules
}

module "nic_vm" {
  source               = "./modules/azurerm_network_interface"
  name                 = "nic-vm-${var.application_name}-${var.environment}"
  location             = module.rg.resource_group_location
  resource_group_name  = module.rg.resource_group_name
  subnet_id            = module.snet["app"].snet_id
  public_ip_address_id = module.pip_vm.pip_id
}

module "nic_nsg_association" {
  source                    = "./modules/azurerm_network_interface_network_security_group_association"
  network_interface_id      = module.nic_vm.nic_id
  network_security_group_id = module.nsg_vm.nsg_id

}

module "bastion_host" {
  source                = "./modules/azurerm_bastion_host"
  name                  = "bastion-${var.application_name}-${var.environment}"
  location              = module.rg.resource_group_location
  resource_group_name   = module.rg.resource_group_name
  ip_configuration_name = "bastion-ipconfig"
  subnet_id             = module.snet["AzureBastionSubnet"].snet_id
  public_ip_address_id  = module.pip_bastion.pip_id
}

data "azurerm_client_config" "current" {

}

module "kv" {
  source                     = "./modules/azurerm_key_vault"
  name                       = "kv-${var.application_name}-${var.environment}"
  location                   = module.rg.resource_group_location
  resource_group_name        = module.rg.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
  rbac_authorization_enabled = true
}

# module "role_kv_admin" {
#   source               = "./modules/azurerm_role_assignment"
#   scope                = module.kv.key_vault_id
#   role_definition_name = "Key Vault Administrator"
#   principal_id         = data.azurerm_client_config.current.object_id
# }

resource "tls_private_key" "vm_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "vm_ssh_private_key" {
  name         = "vm-ssh-private-key"
  value        = tls_private_key.vm_key.private_key_pem
  key_vault_id = module.kv.key_vault_id
}

resource "azurerm_key_vault_secret" "vm_ssh_public_key" {
  name         = "vm-ssh-public-key"
  value        = tls_private_key.vm_key.public_key_openssh
  key_vault_id = module.kv.key_vault_id
}


module "vm" {
  source                 = "./modules/azurerm_linux_virtual_machine"
  vm_name                = "vm1-${var.application_name}-${var.environment}"
  resource_group_name    = module.rg.resource_group_name
  location               = module.rg.resource_group_location
  vm_size                = var.vm_size
  admin_username         = var.vm_admin_username
  network_interface_id   = module.nic_vm.nic_id
  ssh_public_key         = tls_private_key.vm_key.public_key_openssh
  source_image_reference = var.source_image_reference
  os_disk                = var.os_disk
}
