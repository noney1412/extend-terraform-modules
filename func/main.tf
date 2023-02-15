resource "azurerm_resource_group" "func" {
  name     = "${var.project_code}-${var.service_code}-${var.environment_short}-rg"
  location = var.location
}

resource "random_id" "storage_account_suffix" {
  byte_length = 4
}

resource "azurerm_storage_account" "func" {
  name                     = "sta${var.project_code}${var.service_code}${var.environment_short}${random_id.storage_account_suffix.hex}"
  resource_group_name      = azurerm_resource_group.func.name
  location                 = azurerm_resource_group.func.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_service_plan" "func" {
  name                = "asp-${var.project_code}-${var.service_code}-${var.environment_short}-${random_id.storage_account_suffix.hex}"
  resource_group_name = azurerm_resource_group.func.name
  location            = azurerm_resource_group.func.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_windows_function_app" "func" {
  name                = "func-${var.project_code}-${var.service_code}-${var.environment_short}-${random_id.storage_account_suffix.hex}"
  resource_group_name = azurerm_resource_group.func.name
  location            = azurerm_resource_group.func.location

  storage_account_name       = azurerm_storage_account.func.name
  storage_account_access_key = azurerm_storage_account.func.primary_access_key
  service_plan_id            = azurerm_service_plan.func.id

  site_config {}
}
