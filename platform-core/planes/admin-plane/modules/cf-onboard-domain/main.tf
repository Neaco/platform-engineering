

resource "cloudflare_dns_record" "main" {
  zone_id = cloudflare_zone.main.id
  name    = "@"
  ttl     = 1
  type    = "A"
}

resource "cloudflare_dns_record" "main-www" {
  zone_id = cloudflare_zone.main.id
  name    = "www.${var.domain_name}"
  ttl     = 1
  type    = "CNAME"
}
