locals {
  environments_set = toset(["dev", "stage", "prod"])
}

resource "azurerm_redis_cache" "automation" {
  for_each                      = local.environments_set
  name                          = "automation-${var.username}-${each.value}"
  location                      = azurerm_resource_group.automation.location
  resource_group_name           = azurerm_resource_group.automation.name
  capacity                      = 0
  family                        = "C"
  sku_name                      = "Basic"
  non_ssl_port_enabled          = true
  minimum_tls_version           = "1.2"
  tags                          = var.tags
  public_network_access_enabled = false
  #   subnet_id = azurerm_subnet.redis.id
  redis_configuration {
    maxmemory_policy = "allkeys-lru"
    # authentication_enabled = false
  }
}

# output "redis" {
#   value = { for env, redis in azurerm_redis_cache.automation : env => redis.hostname }
# }

output "redis_dev" {
  value = azurerm_redis_cache.automation["dev"].hostname
}

output "redis_stage" {
  value = azurerm_redis_cache.automation["stage"].hostname
}

output "redis_prod" {
  value = azurerm_redis_cache.automation["prod"].hostname
}

resource "azurerm_private_endpoint" "redis" {
  for_each            = local.environments_set
  name                = "redis-automation-${var.username}-${each.value}"
  location            = azurerm_resource_group.automation.location
  resource_group_name = azurerm_resource_group.automation.name
  subnet_id           = azurerm_subnet.redis.id

  private_service_connection {
    name                           = "redis-automation-${each.key}-${var.username}"
    private_connection_resource_id = azurerm_redis_cache.automation[each.key].id
    subresource_names              = ["redisCache"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "automation-${var.username}-${each.value}"
    private_dns_zone_ids = [azurerm_private_dns_zone.redis.id]
  }
}

resource "azurerm_private_dns_zone" "redis" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.automation.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis" {
  name                  = "redis-automation-link"
  resource_group_name   = azurerm_resource_group.automation.name
  private_dns_zone_name = azurerm_private_dns_zone.redis.name
  virtual_network_id    = azurerm_virtual_network.automation.id
}