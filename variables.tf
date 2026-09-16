variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Short name used to prefix/tag resources"
  type        = string
  default     = "devops-assessment"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "availability_zones" {
  description = "AZs to spread subnets across"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

# --- ECS / container ---

variable "container_image" {
  description = "Docker image for the ECS task (placeholder backend or nginx)"
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "Port the application container listens on"
  type        = number
  default     = 80
}

variable "ecs_task_cpu" {
  description = "Fargate task CPU units"
  type        = string
  default     = "256"
}

variable "ecs_task_memory" {
  description = "Fargate task memory (MiB)"
  type        = string
  default     = "512"
}

variable "ecs_desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

# --- RDS ---

variable "db_engine" {
  description = "Database engine: postgres or mysql"
  type        = string
  default     = "postgres"

  validation {
    condition     = contains(["postgres", "mysql"], var.db_engine)
    error_message = "db_engine must be either \"postgres\" or \"mysql\"."
  }
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "app_admin"
}

variable "db_password" {
  description = "Master password for the database (pass via TF_VAR_db_password or a tfvars file that is gitignored)"
  type        = string
  sensitive   = true
}

variable "db_backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "db_deletion_protection" {
  description = "Whether to enable RDS deletion protection"
  type        = bool
  default     = false
}

variable "db_multi_az" {
  description = "Whether to deploy RDS in Multi-AZ mode"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    ManagedBy = "terraform"
  }
}
