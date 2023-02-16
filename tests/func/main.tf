terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.43.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "func" {
  source            = "../../func"
  project_code      = var.project_code
  service_code      = var.service_code
  environment_short = var.environment_short
  location          = var.location
  tags              = var.tags
}
