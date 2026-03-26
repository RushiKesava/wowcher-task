variable "project" {}
variable "vpc_id" {}
variable "private_subnets" {
  type = list(string)
}
variable "certificate_arn" {}