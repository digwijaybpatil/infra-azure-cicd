resource "azurerm_mssql_server" "ms_sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.server_location
  version                      = var.server_version #"12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = var.minimum_tls_version
}