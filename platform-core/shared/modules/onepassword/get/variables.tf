variable "vault_name" {
  type        = string
  description = "The vault in which to retrieve the value"
}

variable "secret_name" {
  type        = string
  description = "The secret's name"
}

variable "section_name" {
  type        = string
  description = "(optional) The field's section. Defaults to the default section"
  default     = "0"
}

variable "field_names" {
  type        = list(string)
  description = "List of fields to retrieve"
  default     = []
}

variable "info_names" {
  description = "List of infos to retrieve"
  type        = list(string)
  default     = []
}

variable "file_names" {
  description = "List of files to retrieve"
  type        = list(string)
  default     = []

}
