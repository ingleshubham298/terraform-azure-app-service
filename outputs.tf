# -------------------------------
# OUTPUT VALUES
# -------------------------------
# These outputs provide important information after deployment
# Use 'terraform output' to view these values after applying

# Production web app URL
output "production_web_app_url" {
  description = "URL of the production web application"
  value       = "https://${azurerm_linux_web_app.wa1.default_hostname}"
}

# Staging slot URL
output "staging_slot_url" {
  description = "URL of the staging deployment slot"
  value       = "https://${azurerm_linux_web_app_slot.slot.default_hostname}"
}

# Resource group name
output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

# App Service Plan name
output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.appserviceplan.name
}

# Web app name
output "web_app_name" {
  description = "Name of the main web application"
  value       = azurerm_linux_web_app.wa1.name
}

# Deployment slot name
output "deployment_slot_name" {
  description = "Name of the deployment slot"
  value       = azurerm_linux_web_app_slot.slot.name
}