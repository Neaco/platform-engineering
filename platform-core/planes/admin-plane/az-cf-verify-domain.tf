module "verify-domain" {
  source      = "./modules/az-cf-add-verified-domain"
  domain_name = var.domain_name
  zone_id     = module.cloudflare_token_generator.infos["zoneID ${var.domain_name}"]
}
