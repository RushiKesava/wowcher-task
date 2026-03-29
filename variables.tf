variable "region" {
  default = "eu-west-2"
}

variable "app_name" {
  default = "test-app"
}

variable "vpc_name" {
  default = "test-vpc"
}

variable "private_subnet_cidrs" {
  default = ["10.20.30.0/24", "10.20.31.0/24"]
}

variable "public_subnet_cidrs" {
  default = ["10.20.32.0/24", "10.20.33.0/24"]
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
}