variable "action_group_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "short_name" {
  type = string
}
variable "email_receiver_name" {
  type = string
}
variable "email_receiver_address" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
