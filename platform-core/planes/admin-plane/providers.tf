terraform {
  required_version = ">=1.10.0, <2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~>3.7"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.8"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>5.15"
    }
  }

  backend "azurerm" {
    use_azuread_auth     = true
    tenant_id            = var.tenant.id
    subscription_id      = var.subscription.id
    resource_group_name  = var.tf-storage.resource_group_name
    storage_account_name = var.tf-storage.name
    container_name       = "tfstate-admin"
    key                  = "admin.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  tenant_id       = var.tenant.id
  subscription_id = var.subscription.id
  features {}
}

provider "cloudflare" {
  api_token = cloudflare_account_token.terraform_token.value
}

provider "cloudflare" {
  alias     = "token-gen"
  api_token = module.cloudflare_token_generator.values.token
}
