# module "generate_cloudflare_token" {
#   source = "./modules/cf-token-gen"
#   providers = {
#     cloudflare = cloudflare.token-gen
#   }
# }

data "cloudflare_account_api_token_permission_groups_list" "full_list" {
  provider = cloudflare.token-gen

  account_id = module.cloudflare_token_generator.infos.accountID
}

locals {
  dns-rights = [
    "Account DNS Settings Read",
    "Account DNS Settings Write",
    #  "Cloudflare Zero Trust Secure DNS Locations Write",
    #    "DNS Firewall Read",
    #    "DNS Firewall Write",
    "DNS Read",
    "DNS View Read",
    "DNS View Write",
    "DNS Write",
    "Zone DNS Settings Read",
    "Zone DNS Settings Write",
  ]

  rights-ids = [
    for right_name in local.dns-rights : one([
      for result in data.cloudflare_account_api_token_permission_groups_list.full_list.result :
      result.id
      if result.name == right_name
    ])
  ]
}


resource "cloudflare_account_token" "terraform_token" {
  provider = cloudflare.token-gen

  account_id = module.cloudflare_token_generator.infos.accountID
  name       = "terraform token"
  policies = [{
    effect = "allow"
    permission_groups = [
      for rights_id in local.rights-ids : {
        id = rights_id
      }
    ]
    resources = jsonencode({ "com.cloudflare.api.account.155aead744c7e90c2564ce85c0226604" = "*" })

  }]
}

module "cloudflare_tf_token" {
  source       = "../../shared/modules/onepassword/create"
  vault_name   = "platform-admin"
  secret_name  = "cloudflare tf token"
  section_name = "token"
  values = {
    id    = cloudflare_account_token.terraform_token.id,
    token = cloudflare_account_token.terraform_token.value
  }
}



# import {
#   to = cloudflare_account_token.terraform_token
#   id = "${nonsensitive(module.cloudflare_secret.infos.accountID)}/fdb1f9299b04553c41b9af9c0d70265b"
# }
# resource "cloudflare_account_token" "terraform_token" {
#   provider = cloudflare.token-gen

#   account_id = module.cloudflare_secret.infos.accountID
#   name       = "terraform token"
#   policies   = []
# }


