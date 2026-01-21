data "onepassword_vault" "vault" {
  name = var.vault_name
}

resource "onepassword_item" "item" {
  vault = data.onepassword_vault.vault.uuid
  title = var.secret_name
  tags  = concat(var.tags, ["created-by-terraform"])

  section {
    label = var.section_name

    dynamic "field" {
      for_each = var.values
      content {
        label = field.key
        type  = "CONCEALED"
        value = field.value
      }
    }

    dynamic "field" {
      for_each = var.fields
      content {
        label = field.key
        type  = "STRING"
        value = field.value
      }
    }
  }
}
