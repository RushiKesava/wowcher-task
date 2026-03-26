output "ecr_repo_url" {
  value = module.ecr.repository_url
}

output "cluster_id" {
  value = module.ecs_cluster.cluster_id
}

output "execution_role_arn" {
  value = module.iam.execution_role_arn
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "ecs_security_group" {
  value = module.alb.ecs_sg
}

output "private_subnets" {
  value = module.network.private_subnets
}

output "alb_dns" {
  value = module.alb.alb_dns
}