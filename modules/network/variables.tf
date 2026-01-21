variable "name" {
  description = "Base name used for naming resources"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where network resources are created"
  type        = string
}

variable "vnet_cidr" {
  description = "VNet address space in CIDR notation"
  type        = string

  validation {
    condition     = can(cidrhost(var.vnet_cidr, 0))
    error_message = "vnet_cidr must be a valid CIDR"
  }
}

variable "aks_subnet_cidr" {
  description = "CIDR for the sdubnet that will host AKS node pools"
  type        = string

  validation {
    condition     = can(cidrhost(var.vnet_cidr, 0))
    error_message = "vnet_cidr must be a valid CIDR"
  }
}

variable "tags" {
  description = "A list of tags to add to the virtual network"
  type        = map(string)
  default     = {}
}
