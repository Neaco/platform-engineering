output "vnet_id" {
  description = "ID of the VNet"
  value       = azurerm_virtual_network.this.id
}

output "aks_subnet_id" {
  description = "ID of the subnet intended for AKS node pools"
  value       = azurerm_subnet.aks.id
}
