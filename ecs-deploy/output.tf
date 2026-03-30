output "service_name" {
  value = module.ecs_app.service_name
}

output "task_definition_arn" {
  value = module.ecs_app.task_definition_arn
}

output "cluster_name" {
  value = var.cluster_name
}