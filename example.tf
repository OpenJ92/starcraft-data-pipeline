provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

variable "app_env" {
  description = "Application environment (e.g., development, staging, production)"
  default     = "development"
}

# S3 Bucket
resource "aws_s3_bucket" "replays" {
  bucket = "${var.app_env}-starcraft-replays"
  acl    = "private"
}

# RDS Instance
resource "aws_db_instance" "starcraft_db" {
  identifier          = "${var.app_env}-starcraft-db"
  allocated_storage   = 20
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  username            = "admin"
  password            = "password"  # Use Secrets Manager for production
  publicly_accessible = false
  skip_final_snapshot = true
}

# ECS Cluster
resource "aws_ecs_cluster" "starcraft_cluster" {
  name = "${var.app_env}-starcraft-cluster"
}

# Fargate Task Definition
resource "aws_ecs_task_definition" "pipeline_task" {
  family                   = "${var.app_env}-starcraft-pipeline"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "1024"

  container_definitions = jsonencode([
    {
      name  = "pipeline-container",
      image = "your-docker-image-uri",  # Replace with your container image
      environment = [
        { name = "APP_ENV", value = var.app_env },
        { name = "DB_CONNECTION_STRING", value = "postgresql://${aws_db_instance.starcraft_db.username}:${aws_db_instance.starcraft_db.password}@${aws_db_instance.starcraft_db.endpoint}" },
        { name = "S3_BUCKET_NAME", value = aws_s3_bucket.replays.bucket }
      ]
    }
  ])
}

# Fargate Service
resource "aws_ecs_service" "pipeline_service" {
  name            = "${var.app_env}-pipeline-service"
  cluster         = aws_ecs_cluster.starcraft_cluster.id
  task_definition = aws_ecs_task_definition.pipeline_task.arn
  desired_count   = 1

  network_configuration {
    subnets         = ["subnet-12345678", "subnet-87654321"]  # Replace with your subnets
    security_groups = ["sg-12345678"]  # Replace with your security group
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.replays.bucket
}

output "rds_endpoint" {
  value = aws_db_instance.starcraft_db.endpoint
}

output "fargate_task_definition_arn" {
  value = aws_ecs_task_definition.pipeline_task.arn
}

