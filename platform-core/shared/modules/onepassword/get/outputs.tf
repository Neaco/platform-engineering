output "values" {
  description = "Secret values"
  value       = local.values
}

output "infos" {
  description = "Secret info"
  value       = local.infos
}

output "files" {
  description = "Secret files"
  value       = local.files
}


output "data" {
  value = data.onepassword_item.item
}
