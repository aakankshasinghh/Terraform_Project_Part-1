resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = merge(var.tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

resource "aws_db_instance" "main" {
  identifier     = "${var.project_name}-db"
  engine         = var.db_engine
  engine_version = local.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage     = var.db_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = local.db_port

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false # RDS must only be reachable from ECS, never the internet

  multi_az                = var.db_multi_az
  backup_retention_period = var.db_backup_retention_period
  deletion_protection     = var.db_deletion_protection
  skip_final_snapshot     = !var.db_deletion_protection
  final_snapshot_identifier = var.db_deletion_protection ? "${var.project_name}-final-snapshot" : null

  tags = merge(var.tags, {
    Name = "${var.project_name}-db"
  })
}
