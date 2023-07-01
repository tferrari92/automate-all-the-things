resource "aws_elasticache_subnet_group" "elasticache-subnet-group" {
  name       = "elasticache-subnet-group"
# subnet_ids = [aws_subnet.private-subnet-c.id] # USAR ESTA AL FINAL, VA A HABER Q GENERARLE UN SECURITY GROUP A ESA SUBNET??? ALLOW INGRESS DESDE public-subnet-c (ec2) y private subnets a y b para los nodos
  subnet_ids = [aws_subnet.public-subnet-c.id]  # PROBAR ESTA SINO, MAS FACIL PARA CONECTAR CON EC2 POR ESTAR EN MISMA SUBNET
}


resource "aws_elasticache_replication_group" "elasticache-replication-group-dev" {
  replication_group_id          = "${var.project}-dev-elascache-rep-group"
  replication_group_description = "Redis cluster for DEV environment"

  node_type            = "cache.t4g.micro"
  port                 = 6379
  parameter_group_name = "default.redis7.cluster.on"

  snapshot_retention_limit = 5
  snapshot_window          = "00:00-05:00"

  subnet_group_name          = "${aws_elasticache_subnet_group.elasticache-subnet-group.name}"
  automatic_failover_enabled = true

  security_group_ids          = [aws_security_group.default.id]
  # security_group_ids          = [aws_security_group.databases.id]

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 1
  }
}

resource "aws_elasticache_replication_group" "elasticache-replication-group-stage" {
  replication_group_id          = "${var.project}-stage-elascache-rep-group"
  replication_group_description = "Redis cluster for STAGE environment"

  node_type            = "cache.t4g.micro"
  port                 = 6379
  parameter_group_name = "default.redis7.cluster.on"

  snapshot_retention_limit = 5
  snapshot_window          = "00:00-05:00"

  subnet_group_name          = "${aws_elasticache_subnet_group.elasticache-subnet-group.name}"
  automatic_failover_enabled = true

  security_group_ids          = [aws_security_group.default.id]
  # security_group_ids          = [aws_security_group.databases.id]

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 1
  }
}

resource "aws_elasticache_replication_group" "elasticache-replication-group-prod" {
  replication_group_id          = "${var.project}-prod-elascache-rep-group"
  replication_group_description = "Redis cluster for PROD environment"

  node_type            = "cache.t4g.micro"
  port                 = 6379
  parameter_group_name = "default.redis7.cluster.on"

  snapshot_retention_limit = 5
  snapshot_window          = "00:00-05:00"

  subnet_group_name          = "${aws_elasticache_subnet_group.elasticache-subnet-group.name}"
  automatic_failover_enabled = true

  security_group_ids          = [aws_security_group.default.id]
  # security_group_ids          = [aws_security_group.databases.id]

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 1
  }
}

output "elasticache_dev_configuration_endpoint_address" {
  value = "${aws_elasticache_replication_group.elasticache-replication-group-dev.configuration_endpoint_address}"
}

output "elasticache_stage_configuration_endpoint_address" {
  value = "${aws_elasticache_replication_group.elasticache-replication-group-stage.configuration_endpoint_address}"
}

output "elasticache_prod_configuration_endpoint_address" {
  value = "${aws_elasticache_replication_group.elasticache-replication-group-prod.configuration_endpoint_address}"
}
  