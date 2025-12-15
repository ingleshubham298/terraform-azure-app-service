# Azure Web App with Deployment Slots - Terraform Project

This Terraform project deploys a complete Azure web application infrastructure with deployment slots for staging and production environments. The setup includes continuous deployment from GitHub repositories.

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    Azure Resource Group                     │
│                      (webapp-rg)                           │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              App Service Plan                        │   │
│  │            (webapp-appserviceplan)                  │   │
│  │                 Linux S1 Tier                       │   │
│  └─────────────────────────────────────────────────────┘   │
│                              │                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Linux Web App                          │   │
│  │               (webapp-s1)                           │   │
│  │              PHP 8.2 Runtime                        │   │
│  │                                                     │   │
│  │  ┌─────────────────────────────────────────────┐   │   │
│  │  │         Deployment Slot                     │   │   │
│  │  │        (webapp-slot)                        │   │   │
│  │  │        PHP 8.2 Runtime                      │   │   │
│  │  └─────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                              │                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │           Source Control Integration                │   │
│  │                                                     │   │
│  │  Production: techmax.git (main branch)             │   │
│  │  Staging: LoopTech-Website.git (main branch)       │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

## 📋 Resources Deployed

### Core Infrastructure
- **Resource Group**: `webapp-rg` in Central India region
- **App Service Plan**: `webapp-appserviceplan` (Linux S1 tier)

### Web Application
- **Linux Web App**: `webapp-s1` with PHP 8.2 runtime
- **Deployment Slot**: `webapp-slot` for staging environment

### Source Control Integration
- **Production Deployment**: Connected to `techmax.git` repository (main branch)
- **Staging Deployment**: Connected to `LoopTech-Website.git` repository (main branch)

## 🚀 Features

- **Blue-Green Deployment**: Use deployment slots for zero-downtime deployments
- **Staging Environment**: Test changes in production-like environment before going live
- **Continuous Deployment**: Automatic deployment from GitHub repositories
- **PHP 8.2 Support**: Latest PHP runtime for modern applications
- **Linux Hosting**: Cost-effective Linux-based hosting environment

## 📁 Project Structure

```
.
├── main.tf              # Main web app and deployment resources
├── provider.tf          # Terraform and Azure provider configuration
├── rg.tf               # Resource group and local variables
├── .terraform.lock.hcl # Provider version lock file
└── README.md           # This documentation
```

## 🛠️ Prerequisites

Before deploying this infrastructure, ensure you have:

1. **Azure CLI** installed and configured
   ```bash
   az login
   az account set --subscription "your-subscription-id"
   ```

2. **Terraform** installed (version >= 1.5.7)
   ```bash
   terraform version
   ```

3. **Azure Subscription** with appropriate permissions to create:
   - Resource Groups
   - App Service Plans
   - Web Apps
   - Source Control configurations

## 🚀 Deployment Instructions

### 1. Clone the Repository
```bash
git clone <your-repository-url>
cd <repository-name>
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Review the Deployment Plan
```bash
terraform plan
```

### 4. Deploy the Infrastructure
```bash
terraform apply
```

### 5. Confirm Deployment
Type `yes` when prompted to confirm the deployment.

## 🔧 Configuration

### Local Variables (rg.tf)
- `name`: Base name for all resources (default: "webapp")
- `location`: Azure region (default: "Central India")

### App Service Plan Configuration
- **OS Type**: Linux
- **SKU**: S1 (Standard tier)
- **Features**: Supports deployment slots, auto-scaling

### Web App Configuration
- **Runtime**: PHP 8.2
- **Platform**: Linux
- **Deployment**: Manual integration with GitHub

## 🌐 Accessing Your Applications

After deployment, your applications will be available at:

- **Production Web App**: `https://webapp-s1.azurewebsites.net`
- **Staging Slot**: `https://webapp-s1-webapp-slot.azurewebsites.net`

## 🔄 Deployment Workflow

### Staging to Production Swap
1. Deploy and test changes in the staging slot
2. Use Azure portal or CLI to swap slots:
   ```bash
   az webapp deployment slot swap \
     --resource-group webapp-rg \
     --name webapp-s1 \
     --slot webapp-slot \
     --target-slot production
   ```

### Manual Deployment Trigger
```bash
az webapp deployment source sync \
  --resource-group webapp-rg \
  --name webapp-s1 \
  --slot webapp-slot
```

## 🔒 Security Considerations

- Source control uses manual integration (webhooks disabled)
- Consider enabling HTTPS-only access in production
- Implement proper authentication for sensitive applications
- Review and configure custom domains with SSL certificates

## 🧹 Cleanup

To destroy all resources and avoid ongoing charges:

```bash
terraform destroy
```

Type `yes` when prompted to confirm the destruction.

## 📝 Customization

### Adding Environment Variables
Add to the `site_config` block in `main.tf`:
```hcl
site_config {
  application_stack {
    php_version = "8.2"
  }
  
  app_settings = {
    "ENVIRONMENT" = "production"
    "DEBUG_MODE"  = "false"
  }
}
```

### Enabling HTTPS Only
Add to web app resource:
```hcl
resource "azurerm_linux_web_app" "wa1" {
  # ... existing configuration
  https_only = true
}
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the deployment
5. Submit a pull request

---

**Author**: Shubham Ingle
**Last Updated**: December 2024  
**Terraform Version**: >= 1.5.7  
**Azure Provider Version**: ~> 4.0# terraform-azure-app-service
