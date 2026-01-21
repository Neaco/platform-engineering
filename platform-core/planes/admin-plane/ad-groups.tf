
resource "azuread_group" "env-groups" {
  for_each = merge([
    for _, envval in var.envs : {
      for k, v in var.env-groups : "${k}-${envval.name}" => {
        name  = format(v.name, envval.name)
        descr = format(v.descr, envval.name)
      }
    }
  ]...)

  display_name       = each.value.name
  security_enabled   = true
  assignable_to_role = false
  members            = [for admin in azuread_user.admins : admin.object_id]
}
