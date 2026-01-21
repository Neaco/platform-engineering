data "azurerm_storage_account" "tf_state" {
  name                = var.tf-storage.name
  resource_group_name = var.tf-storage.resource_group_name
}

resource "azurerm_storage_container" "tf_state" {
  for_each = var.envs

  name                  = "tfstate-${each.value.name}"
  storage_account_id    = data.azurerm_storage_account.tf_state.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "tf_role" {
  for_each = var.envs

  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_group.env-groups["contributor-terraform-${each.value.name}"].object_id
  scope                = azurerm_storage_container.tf_state[each.key].resource_manager_id
}
