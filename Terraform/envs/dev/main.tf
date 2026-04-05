resource "azurerm_resource_group" "this" {
  name     = "rg-aks-dev"
  location = var.location
}

module "network" {
  source              = "../../modules/Network"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  vnet_cidr           = var.vnet_cidr
  subnet_cidr         = var.subnet_cidr
}

module "acr" {
  source              = "../../modules/ACR"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
}

module "aks" {
  source              = "../../modules/AKS"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  subnet_id           = module.network.subnet_id
  acr_id              = module.acr.acr_id
  aks_name            = var.aks_name
}

resource "azurerm_dns_zone" "main" {
  name                = "gitops-test.space"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_dns_a_record" "myapp" {
  name                = "myapp"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = azurerm_resource_group.this.name
  ttl                 = 300
  records             = ["135.235.191.139"] # your ingress IP
}