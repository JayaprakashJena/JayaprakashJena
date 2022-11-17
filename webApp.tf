
terraform {
  required_version = ">= 0.11"
  backend "azurem"{
    storage_account_name = "__terraformstorageaccount__"
    container_name = "terraform"
    key = "terraform.tfstate"
    access_key = "__storagekey__"
    features{}
  }
  provider "azurerm" {
   features {}
 }
}

resource "azurerm_resource_group" "res-Jay" {
  name     = "Terraform-resources"
  location = "East US"
}

resource "azurerm_service_plan" "AppServicePlan" {
  name                = "AppPlan01"
  resource_group_name = azurerm_resource_group.res-Jay.name
  location            = azurerm_resource_group.res-Jay.location
  sku_name            = "S1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "WebApp01" {
  name                = "WinApp01"
  resource_group_name = azurerm_resource_group.res-Jay.name
  location            = azurerm_service_plan.AppServicePlan.location
  service_plan_id     = azurerm_service_plan.AppServicePlan.id



  site_config {}
}