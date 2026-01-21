variable "vault_name" {
  type        = string
  description = "Name of the vault"
}

variable "secret_name" {
  type        = string
  description = "Name of the secret"
}

#Can't be default because the provider errors
variable "section_name" {
  type        = string
  description = "Name of the section"
}

variable "values" {
  type        = map(string)
  description = "Map of secret names and values"
}

variable "fields" {
  type        = map(string)
  description = "Map of fields"
  default     = {}
}

variable "tags" {
  type        = list(string)
  description = "List of tags"
  default     = []
}
