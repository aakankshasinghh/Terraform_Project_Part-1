locals {
  db_port           = var.db_engine == "postgres" ? 5432 : 3306
  db_engine_version = var.db_engine == "postgres" ? "16.3" : "8.0.35"
  db_family         = var.db_engine == "postgres" ? "postgres16" : "mysql8.0"
}
