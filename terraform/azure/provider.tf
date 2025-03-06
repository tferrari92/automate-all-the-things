terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0, < 5.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "automatethingandrei"
    container_name       = "terraform-state"
    key                  = "automate-all-the-things.tfstate"
    use_azuread_auth     = true
  }
}



# ----------------- Azure -----------------

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}
