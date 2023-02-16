resource "random_id" "suffix" {
  byte_length = 2
}
resource "azurerm_resource_group" "func" {
  name     = "${var.project_code}-${var.service_code}-${var.environment_short}-rg-${random_id.suffix.dec}"
  location = var.location
  tags     = var.tags
}
resource "azurerm_storage_account" "func" {
  name                     = "sta${var.project_code}${var.service_code}${var.environment_short}${random_id.suffix.dec}"
  resource_group_name      = azurerm_resource_group.func.name
  location                 = azurerm_resource_group.func.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_service_plan" "func" {
  name                = "asp-${var.project_code}-${var.service_code}-${var.environment_short}-${random_id.suffix.dec}"
  resource_group_name = azurerm_resource_group.func.name
  location            = azurerm_resource_group.func.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_application_insights" "func" {
  name                = "ain-${var.project_code}-${var.service_code}-${var.environment_short}-${random_id.suffix.dec}"
  resource_group_name = azurerm_resource_group.func.name
  location            = azurerm_resource_group.func.location
  application_type    = "web"
}

resource "azurerm_linux_function_app" "func" {
  name                = "func-${var.project_code}-${var.service_code}-${var.environment_short}-${random_id.suffix.dec}"
  resource_group_name = azurerm_resource_group.func.name
  location            = azurerm_resource_group.func.location

  storage_account_name        = azurerm_storage_account.func.name
  storage_account_access_key  = azurerm_storage_account.func.primary_access_key
  service_plan_id             = azurerm_service_plan.func.id
  functions_extension_version = "~4"
  client_certificate_mode     = "Required"
  https_only                  = true

  site_config {
    application_stack {
      node_version = "18"
    }

    application_insights_key               = azurerm_application_insights.func.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.func.connection_string

    cors {
      allowed_origins = [
        "https://portal.azure.com",
      ]
      support_credentials = false
    }

  }

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = true
  }
}

