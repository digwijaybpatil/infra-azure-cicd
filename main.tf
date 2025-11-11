module "rg" {
  source   = "./modules/azurerm_resource_group"
  name     = "rg-${var.application_name}-${var.environment}"
  location = var.primary_location
}

module "vnet" {
  source              = "./modules/azurerm_virtual_network"
  name                = "vnet-${var.application_name}-${var.environment}"
  address_space       = var.vnet_address_space
  location            = var.primary_location
  resource_group_name = module.rg.resource_group_name
}

locals {
  subnets = {
    bastion = cidrsubnet(var.vnet_address_space, 4, 0)
    app     = cidrsubnet(var.vnet_address_space, 2, 1)
    data    = cidrsubnet(var.vnet_address_space, 2, 2)
    web     = cidrsubnet(var.vnet_address_space, 2, 3)
  }
}

module "snet" {
  source               = "./modules/azurerm_subnet"
  for_each             = local.subnets
  name                 = "${each.key}-snet-${var.application_name}-${var.environment}"
  virtual_network_name = module.vnet.name
  resource_group_name  = module.rg.resource_group_name
  address_prefixes     = each.value
}


