resource "azurerm_mysql_flexible_server" "this" {
  name                   = var.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location

  administrator_login    = var.admin_username
  administrator_password = var.admin_password

  sku_name               = var.sku_name
  version                = var.msversion

  backup_retention_days  = var.backup_retention_days
  delegated_subnet_id    = var.delegated_subnet_id


 
}

