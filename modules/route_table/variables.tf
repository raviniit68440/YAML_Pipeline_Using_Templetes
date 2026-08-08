variable "name" {
  type        = string
  description = "Name of the route table"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "bgp_route_propagation_enabled" {
  type        = bool
  description = "Boolean flag which controls propagation of routes learned by BGP on that route table"
  default     = true
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to associate with this Route Table"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}
