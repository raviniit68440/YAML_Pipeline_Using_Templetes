variable "location" {
  type        = string
  description = "The default Azure region for resources."
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, uat, prod)."
}

variable "hub_vnet_address_space" {
  type        = list(string)
  description = "Address space for the Hub VNet."
}

variable "spoke_vnet_address_space" {
  type        = list(string)
  description = "Address space for the Spoke VNet."
}

variable "tags" {
  type        = map(string)
  description = "Default tags for all resources."
  default     = {}
}
