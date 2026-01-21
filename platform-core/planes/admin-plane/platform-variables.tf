variable "envs" {
  type = map(object({
    name = string
  }))
}

variable "users" {
  type = map(object({
    name       = string
    user_email = string
  }))
}

variable "admins" {
  type = map(object({
    name                = string
    user_principal_name = string
  }))
}

variable "env-groups" {
  type = map(object({
    name  = string
    descr = string
  }))
}

variable "tenant" {
  type = object({
    id = string
  })
}

variable "subscription" {
  type = object({
    id = string
  })
}

variable "tf-storage" {
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "domain_name" {
  type = string
}
