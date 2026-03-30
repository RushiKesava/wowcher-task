variable "env" {}
variable "cluster_name" {}
variable "service_name" {}
variable "container_name" {}
variable "image_url" {}
variable "cpu" { default = "256" }
variable "memory" { default = "512" }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "target_group_arn" {}
variable "desired_count" { default = 1 }
variable "execution_role_arn" {}
variable "task_role_arn" {}

variable "secrets" {
  description = "A list of secrets from SSM or Secrets Manager to inject into the task"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}