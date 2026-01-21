data "onepassword_item" "item" {
  vault = var.vault_name
  title = var.secret_name
}

locals {

  section_index = var.section_name == "0" ? 0 : one([for i, v in data.onepassword_item.item.section : v.label == var.section_name ? i : null])

  values = {
    for field_name in var.field_names : field_name => one([
      for field in data.onepassword_item.item.section[local.section_index].field :
      field.value
      if field.label == field_name && field.type == "CONCEALED"
    ])
  }

  infos = {
    for info_name in var.info_names : info_name => one([
      for field in data.onepassword_item.item.section[local.section_index].field :
      field.value
      if field.label == info_name && field.type != "CONCEALED"
    ])
  }

  files = {
    for file_name in var.file_names : file_name => data.onepassword_item.item.section[local.section_index].file[
      index(data.onepassword_item.item.section[local.section_index].file[*].name, file_name)
    ].content
  }
}
