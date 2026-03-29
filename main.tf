provider "aws" {
  region = var.region
}

# -----------------------------
# NETWORK (Existing VPC)
# -----------------------------
module "network" {
  source = "../modules/network"

  vpc_name              = var.vpc_name
  private_subnet_cidrs  = var.private_subnet_cidrs
  public_subnet_cidrs   = var.public_subnet_cidrs
}

# -----------------------------
# ECR Repository
# -----------------------------
module "ecr" {
  source = "../modules/ecr"

  repo_name = var.app_name
}

# -----------------------------
# IAM Role (ECS Execution)
# -----------------------------
module "iam" {
  source = "../modules/iam"

  project = var.app_name
}

# -----------------------------
# ECS Cluster
# -----------------------------
module "ecs_cluster" {
  source = "../modules/ecs-cluster"

  cluster_name = "${var.app_name}-cluster"
}

# -----------------------------
# ALB + Security Groups
# -----------------------------
module "alb" {
  source = "../modules/alb"

  project          = var.app_name
  vpc_id           = module.network.vpc_id
  private_subnets  = module.network.private_subnets
  certificate_arn  = var.certificate_arn
}

# -----------------------------
# ECS Service
# -----------------------------
module "ecs_service" {
  source = "../modules/ecs-service"

  project              = var.app_name
  cluster_id           = module.ecs_cluster.cluster_id
  cluster_name         = "${var.app_name}-cluster"
  repository_url       = module.ecr.repository_url
  execution_role_arn   = module.iam.execution_role_arn
  task_role_arn        = module.iam.task_role_arn
  private_subnets      = module.network.private_subnets
  ecs_sg_id            = module.alb.ecs_sg
  target_group_arn     = module.alb.target_group_arn
  region               = var.region
}