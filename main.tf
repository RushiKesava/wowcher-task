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

  repo_name = var.project_name
}

# -----------------------------
# IAM Role (ECS Execution)
# -----------------------------
module "iam" {
  source = "../modules/iam"

  project = var.project_name
}

# -----------------------------
# ECS Cluster
# -----------------------------
module "ecs_cluster" {
  source = "../modules/ecs-cluster"

  cluster_name = "${var.project_name}-cluster"
}

# -----------------------------
# ALB + Security Groups
# -----------------------------
module "alb" {
  source = "../modules/alb"

  project          = var.project_name
  vpc_id           = module.network.vpc_id
  private_subnets  = module.network.private_subnets
  certificate_arn  = var.certificate_arn
}