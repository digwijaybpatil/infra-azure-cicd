resource "azurerm_mysql_flexible_database" "this" {
  name                = var.database_name
  server_name         = var.server_name
  resource_group_name = var.resource_group_name
  charset             = "utf8mb3"
  collation           = "utf8mb3_general_ci"
}
