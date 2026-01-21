module "cloudflare_token_generator" {
  source      = "../../shared/modules/onepassword/get"
  vault_name  = "platform-admin"
  secret_name = "Cloudflare account"
  field_names = ["token"]
  info_names  = ["accountID", "zoneID ${var.domain_name}"]
}
