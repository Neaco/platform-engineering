terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>5.15"
    }
  }
  required_version = ">1.1.0"
}
