variable "name" {
  type        = string
  description = "Name of the storage account"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account"
  default     = "LRS"
}

variable "container_name" {
  type        = string
  description = "Name of the storage container for terraform state"
  default     = "tfstate"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}
