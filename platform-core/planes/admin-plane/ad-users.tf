
resource "random_password" "user_pass" {
  for_each = var.users

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azuread_user" "users" {
  depends_on = [random_password.user_pass]
  for_each   = var.users

  user_principal_name = each.value.user_email
  display_name        = each.value.name
  password            = random_password.user_pass[each.key].result
}


resource "random_password" "admin_pass" {
  for_each = var.admins

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azuread_user" "admins" {
  depends_on = [random_password.admin_pass]
  for_each   = var.admins

  user_principal_name = each.value.user_principal_name
  display_name        = each.value.name
  password            = random_password.admin_pass[each.key].result
}

module "admin-accounts" {
  for_each     = var.admins
  source       = "../../shared/modules/onepassword/create"
  secret_name  = each.key
  section_name = "Az account"
  vault_name   = "platform-admin"
  fields = {
    account = each.value.user_principal_name
  }
  values = {
    password = random_password.admin_pass[each.key].result
  }
}
