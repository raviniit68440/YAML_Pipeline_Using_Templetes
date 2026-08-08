resource "azurerm_monitor_action_group" "this" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.short_name
  tags                = var.tags

  email_receiver {
    name                    = var.email_receiver_name
    email_address           = var.email_receiver_address
    use_common_alert_schema = true
  }
}
