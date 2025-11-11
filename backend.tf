terraform {
  backend "azurerm" {
    resource_group_name  = "rg-digwi-terraform-remote"
    storage_account_name = "stgdigwiterraformstate"
    container_name       = "tfstate"
    key                  = "placeholder.tfstate" # overridden by pipeline variable
  }
}