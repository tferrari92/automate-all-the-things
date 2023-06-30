resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name       = "elasticache-subnet-group"
# subnet_ids = [aws_subnet.private-subnet-c.id] # USAR ESTA AL FINAL, VA A HABER Q GENERARLE UN SECURITY GROUP A ESA SUBNET??? ALLOW INGRESS DESDE public-subnet-c (ec2) y private subnets a y b para los nodos
  subnet_ids = [aws_subnet.public-subnet-c.id]  # PROBAR ESTA SINO, MAS FACIL PARA CONECTAR CON EC2 POR ESTAR EN MISMA SUBNET
}


resource "aws_elasticache_replication_group" "elasticache_replication_group" {
  replication_group_id          = "${var.project}-elasticache-replication-group"
  replication_group_description = "Redis cluster for Hashicorp ElastiCache example"

  node_type            = "cache.t4g.micro"
  port                 = 6379
  parameter_group_name = "default.redis7.cluster.on"

  snapshot_retention_limit = 5
  snapshot_window          = "00:00-05:00"

  subnet_group_name          = "${aws_elasticache_subnet_group.elasticache_subnet_group.name}"
  automatic_failover_enabled = true

  security_group_ids          = [aws_security_group.default.id]
  # security_group_ids          = [aws_security_group.databases.id]

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 2
  }
}