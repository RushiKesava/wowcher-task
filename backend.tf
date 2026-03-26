backend "s3" {
  bucket         = "wowcher-terraform-state-bucket"
  key            = "ecs/dev/terraform.tfstate"
  region         = "eu-west-2"
  dynamodb_table = "terraform-lock-table"
}