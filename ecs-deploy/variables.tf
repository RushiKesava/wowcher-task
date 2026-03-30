variable "env" {
  description = "Execution environment (dev, stage, prod)"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-2"
}

variable "cluster_name" {
  description = "The name of the existing ECS cluster"
  type        = string
}

variable "image_url" {
  description = "The ECR image URL to deploy"
  type        = string
}

variable "private_subnets" {
  description = "The private subnets for the ECS service"
  type        = list(string)
}

variable "app_security_group_ids" {
  description = "The security group IDs for the ECS service"
  type        = list(string)
}

variable "target_group_arn" {
  description = "The ARN of the existing ALB target group"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the existing ECS Task Execution Role"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the existing ECS Task Role"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 2
}

variable "cpu" {
  description = "vCPU units (256, 512, 1024)"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memory units (512, 1024, 2048)"
  type        = string
  default     = "512"
}