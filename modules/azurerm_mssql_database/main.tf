resource "azurerm_mssql_database" "this" {
  name      = var.database_name
  server_id = var.server_id

  collation    = var.collation
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name

}