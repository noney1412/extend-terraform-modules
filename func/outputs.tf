output "storage_account_name" {
  value = azurerm_storage_account.func.name
}

output "func_app_name" {
  value = azurerm_windows_function_app.func.name
}

