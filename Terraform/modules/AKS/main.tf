resource "azurerm_kubernetes_cluster" "this" {
  name                = "dev-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "devaks"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_B2s"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    service_cidr      = "172.16.0.0/16"
    dns_service_ip    = "172.16.0.10"
    
  }
}
