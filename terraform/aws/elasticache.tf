resource "aws_elasticache_subnet_group" "elasticache-subnet-group" {
  name       = "elasticache-subnet-group"
  subnet_ids = [aws_subnet.private-subnet-c.id]
}


resource "aws_elasticache_replication_group" "elasticache-replication-group-dev" {
  replication_group_id          = "${var.project}-dev-elascache-rep-group"
  replication_group_description = "Redis cluster for DEV environment"

  node_type            = "cache.t4g.micro"
  port                 = 6379
  parameter_group_name = "default.redis7"
  engine_version           = "7.0"

  snapshot_retention_limit = 5
  snapshot_window          = "00:00-05:00"

  subnet_group_name          = "${aws_elasticache_subnet_group.elasticache-subnet-group.name}"
  automatic_failover_enabled = false  # Disable cluster mode

  security_group_ids          = [aws_security_group.databases.id]

  cluster_mode {
    replicas_per_node_group = 1
  }
}

resource "aws_elasticache_replication_group" "elasticache-replication-group-stage" {
  replication_group_id          = "${var.project}-stage-elascache-rep-group"
  replication_group_description = "Redis cluster for STAGE environment"

  node_type            = "cache.t4g.micro"
  port                 = 6379
  parameter_group_name = "default.redis7"
  engine_version           = "7.0"

  snapshot_retention_limit = 5
  snapshot_window          = "00:00-05:00"

  subnet_group_name          = "${aws_elasticache_subnet_group.elasticache-subnet-group.name}"
  automatic_failover_enabled = false  # Disable cluster mode

  security_group_ids          = [aws_security_group.databases.id]

  cluster_mode {
    replicas_per_node_group = 1
  }
}

resource "aws_elasticache_replication_group" "elasticache-replication-group-prod" {
  replication_group_id          = "${var.project}-prod-elascache-rep-group"
  replication_group_description = "Redis cluster for PROD environment"

  node_type            = "cache.t4g.micro"
  port                 = 6379
  parameter_group_name = "default.redis7"
  engine_version           = "7.0"

  snapshot_retention_limit = 5
  snapshot_window          = "00:00-05:00"

  subnet_group_name          = "${aws_elasticache_subnet_group.elasticache-subnet-group.name}"
  automatic_failover_enabled = false  # Disable cluster mode

  security_group_ids          = [aws_security_group.databases.id]

  cluster_mode {
    replicas_per_node_group = 1
  }
}

output "elasticache_dev_primary_endpoint_address" {
  value = "${aws_elasticache_replication_group.elasticache-replication-group-dev.primary_endpoint_address}"
}

output "elasticache_stage_primary_endpoint_address" {
  value = "${aws_elasticache_replication_group.elasticache-replication-group-stage.primary_endpoint_address}"
}

output "elasticache_prod_primary_endpoint_address" {
  value = "${aws_elasticache_replication_group.elasticache-replication-group-prod.primary_endpoint_address}"
}