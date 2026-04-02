variable "region" {
  default = "eu-west-2"
}

variable "bucket_name" {
  default = "wowcher-terraform-state-bucket"
}

variable "dynamodb_table" {
  default = "terraform-lock-table"
}