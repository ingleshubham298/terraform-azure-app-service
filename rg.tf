
# -------------------------------
# LOCALS
# -------------------------------
# Defining local variables for reuse throughout the configuration.
# This helps in maintaining consistency for naming conventions and location.
locals {
  name     = "webapp"
  location = "Central India"
}

# -------------------------------
# RESOURCE GROUP
# -------------------------------
# Creating a Resource Group to organize all related resources.
# The name is dynamically generated using the local variable.
resource "azurerm_resource_group" "rg" {
  name     = "${local.name}-rg"
  location = local.location
}
