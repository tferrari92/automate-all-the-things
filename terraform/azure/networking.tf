resource "azurerm_resource_group" "automation" {
  name     = "${var.resource_group_name}-${var.username}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "automation" {
  name                = "automation-${var.username}"
  location            = azurerm_resource_group.automation.location
  resource_group_name = azurerm_resource_group.automation.name
  address_space       = ["10.0.0.0/16"]
  tags                = var.tags
}

resource "azurerm_subnet" "internal_aks" {
  name                 = "private-aks-${var.username}"
  resource_group_name  = azurerm_resource_group.automation.name
  virtual_network_name = azurerm_virtual_network.automation.name
  address_prefixes     = ["${cidrsubnet(one(azurerm_virtual_network.automation.address_space), 8, 0)}"]
}

resource "azurerm_network_security_group" "internal_aks" {
  name                = "private-automation-${var.username}"
  location            = azurerm_resource_group.automation.location
  resource_group_name = azurerm_resource_group.automation.name

  security_rule {
    name                       = "AllowAllInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "internal_aks" {
  subnet_id                 = azurerm_subnet.internal_aks.id
  network_security_group_id = azurerm_network_security_group.internal_aks.id
}

resource "azurerm_public_ip" "nat" {
  name                = "automation-nat-${var.username}"
  location            = azurerm_resource_group.automation.location
  resource_group_name = azurerm_resource_group.automation.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "automation" {
  name                = "automation-${var.username}"
  location            = azurerm_resource_group.automation.location
  resource_group_name = azurerm_resource_group.automation.name
  zones               = ["1"]
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "graphdb_nat_gateway" {
  nat_gateway_id       = azurerm_nat_gateway.automation.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "graphdb_nat_gateway" {
  nat_gateway_id = azurerm_nat_gateway.automation.id
  subnet_id      = azurerm_subnet.internal_aks.id
}

resource "azurerm_subnet" "redis" {
  name                 = "private-redis-${var.username}"
  resource_group_name  = azurerm_resource_group.automation.name
  virtual_network_name = azurerm_virtual_network.automation.name
  address_prefixes     = ["${cidrsubnet(one(azurerm_virtual_network.automation.address_space), 8, 1)}"]
}

resource "azurerm_subnet_network_security_group_association" "redis" {
  subnet_id                 = azurerm_subnet.redis.id
  network_security_group_id = azurerm_network_security_group.internal_aks.id
}