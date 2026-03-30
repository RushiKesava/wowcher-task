provider "aws" {
  region = var.region
}

# -----------------------------------
# 🔹 ECS APP MODULE (Reference Existing Resources)
# -----------------------------------

module "ecs_app" {
  source = "./modules/ecs-service"

  env                = var.env
  cluster_name       = var.cluster_name
  service_name       = "${var.env}-service"
  container_name     = "test-app"
  image_url          = var.image_url
  cpu                = var.cpu
  memory             = var.memory
  subnet_ids         = var.private_subnets
  security_group_ids = var.app_security_group_ids
  target_group_arn   = var.target_group_arn
  desired_count      = var.desired_count
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  # Injecting secrets from pre-created SSM parameters
  secrets = [
    {
      name      = "DB_USERNAME"
      valueFrom = "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.env}/db_username"
    },
    {
      name      = "DB_PASSWORD"
      valueFrom = "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.env}/db_password"
    }
  ]
}

data "aws_caller_identity" "current" {}