variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "size" {
  type    = string
  default = "Standard_D2s_v3"
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type      = string
  sensitive = true
}
variable "app_gateway_backend_pool_id" {
  type    = string
  default = ""
}
variable "recovery_vault_name" {
  type    = string
  default = ""
}
variable "recovery_vault_resource_group_name" {
  type    = string
  default = ""
}
variable "backup_policy_id" {
  type    = string
  default = ""
}
variable "tags" {
  type    = map(string)
  default = {}
}
