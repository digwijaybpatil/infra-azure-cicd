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

# module "pip-vm" {
#   source              = "./modules/azurerm_public_ip"
#   name                = "pip-vm-${var.application_name}-${var.environment}"
#   location            = module.rg.resource_group_location
#   resource_group_name = module.rg.resource_group_name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }


module "nic-vm1" {
  source              = "./modules/azurerm_nic"
  name                = "nic-vm1-${var.application_name}-${var.environment}"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  subnet_id           = module.snet["app"].snet_id
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
  enable_rbac_authorization  = true
}

module "role_kv_admin" {
  source               = "./modules/azurerm_role_assignment"
  scope                = module.kv.key_vault_id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}


