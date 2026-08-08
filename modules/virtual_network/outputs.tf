output "id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "name" {
  description = "The Name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}
