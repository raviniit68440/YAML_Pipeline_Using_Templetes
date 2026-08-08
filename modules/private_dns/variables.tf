variable "name" {
  type        = string
  description = "Name of the Private DNS Zone"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "virtual_network_id" {
  type        = string
  description = "The ID of the Virtual Network that should be linked to the DNS Zone"
}

variable "registration_enabled" {
  type        = bool
  description = "Is auto-registration of virtual machine records in the virtual network enabled?"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}
