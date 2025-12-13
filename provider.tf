# Terraform configuration block
# Specifies the minimum Terraform version and required providers
terraform {
  required_version = ">= 1.5.7"  # Minimum Terraform version required
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"  # Azure Resource Manager provider
      version = "~> 4.0"             # Use version 4.x (allows minor updates)
    }
  }
}

# Configure the Azure Provider
# This provider enables Terraform to manage Azure resources
provider "azurerm" {
  features {}  # Enable all provider features with default settings
}
