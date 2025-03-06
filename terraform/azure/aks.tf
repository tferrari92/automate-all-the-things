locals {
  aks_service_cidr = cidrsubnet(one(azurerm_virtual_network.automation.address_space), 8, 10)
}

resource "azurerm_kubernetes_cluster" "automation" {
  name                      = "automation-${var.username}"
  location                  = azurerm_resource_group.automation.location
  resource_group_name       = azurerm_resource_group.automation.name
  dns_prefix                = "automationaks1"
  automatic_upgrade_channel = "patch"
  kubernetes_version        = "1.30"
  tags                      = var.tags

  default_node_pool {
    name                 = "automation"
    node_count           = 2
    min_count            = 1
    max_count            = 5
    vm_size              = "Standard_B2s"
    zones                = ["1", "2", "3"]
    auto_scaling_enabled = true
    vnet_subnet_id       = azurerm_subnet.internal_aks.id
    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = local.aks_service_cidr
    dns_service_ip = cidrhost(local.aks_service_cidr, 10)
  }

  web_app_routing {
    dns_zone_ids = []
  }
}