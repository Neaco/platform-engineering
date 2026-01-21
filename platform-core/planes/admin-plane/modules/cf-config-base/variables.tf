variable "base_domain" {
  type        = string
  description = "The default domain to be used"

}

variable "dnssec_enabled" {
  type        = bool
  description = "(optional) Whether th dnssec should be enabled. Default is 'false'"
  default     = false
}

variable "type_plan" {
  type        = string
  description = "(optional) The plan type of the zone. Default is 'free'"
  default     = free
}
