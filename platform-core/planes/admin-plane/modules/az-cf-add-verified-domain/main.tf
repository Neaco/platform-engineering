data "external" "aad_domain_dns" {
  program = [
    "${path.module}/../../../../scripts/aad_domain_bootstrap.sh",
    var.domain_name
  ]
}

resource "cloudflare_dns_record" "aad_verification" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = data.external.aad_domain_dns.result.name
  ttl     = data.external.aad_domain_dns.result.ttl
  content = data.external.aad_domain_dns.result.value
  comment = "AAD domain verification record"
}


resource "null_resource" "validate_verification" {
  depends_on = [cloudflare_dns_record.aad_verification]

  provisioner "local-exec" {
    command = "${path.module}/../../../../scripts/aad_validate_domain_verified.sh ${var.domain_name}"
  }
}
