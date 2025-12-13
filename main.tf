# -------------------------------
# APP SERVICE PLAN
# -------------------------------
# Creating an App Service Plan (ASP) which defines the compute resources for the web app.
# Sku 'S1' indicates a Standard tier which supports slots and auto-scaling.
# os_type 'Linux' specifies that the underlying host is Linux-based.
resource "azurerm_service_plan" "appserviceplan" {
  name                = "${local.name}-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "S1"
}

# -------------------------------
# LINUX WEB APP
# -------------------------------
# Creating the main Web App resource which hosts the application.
# It is linked to the App Service Plan created above.
resource "azurerm_linux_web_app" "wa1" {
  name                = "${local.name}-s1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  # Configuration for the application stack, setting PHP version to 8.2.
  site_config {
    application_stack {
      php_version = "8.2"
    }
  }
}

# -------------------------------
# MAIN WEB APP SOURCE CONTROL
# -------------------------------
# Configuring Source Control Manager (SCM) for the main web app.
# It connects the web app to a GitHub repository to deploy code from the 'main' branch.
# 'use_manual_integration = true' allows for manual syncs if webhooks aren't configured.
resource "azurerm_app_service_source_control" "main_sc" {
  app_id   = azurerm_linux_web_app.wa1.id
  repo_url = "https://github.com/ingleshubham298/techmax.git"
  branch   = "main"

  use_manual_integration = true
}

# -------------------------------
# DEPLOYMENT SLOT
# -------------------------------
# Creating a deployment slot for the web app. Slots are useful for staging and testing
# changes before swapping them to the production slot.
resource "azurerm_linux_web_app_slot" "slot" {
  name           = "${local.name}-slot"
  app_service_id = azurerm_linux_web_app.wa1.id

  # Matching the stack configuration of the main app.
  site_config {
    application_stack {
      php_version = "8.2"
    }
  }
}

# -------------------------------
# SLOT SOURCE CONTROL (CORRECT)
# -------------------------------
# Configuring Source Control for the deployment slot.
# Note that this points to a DIFFERENT repository or branch to allow independent testing.
resource "azurerm_app_service_source_control_slot" "slot_sc" {
  slot_id  = azurerm_linux_web_app_slot.slot.id
  repo_url = "https://github.com/ingleshubham298/LoopTech-Website.git"
  branch   = "main"

  use_manual_integration = true
}


