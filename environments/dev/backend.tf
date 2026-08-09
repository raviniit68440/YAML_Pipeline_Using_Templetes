# Ensure the storage account exists before running init
backend "azurerm" {
  resource_group_name  = "rg-terraform-state"
  storage_account_name = "sttfstatedevxxxx"
  container_name       = "tfstate"
  key                  = "dev.terraform.tfstate"
}
