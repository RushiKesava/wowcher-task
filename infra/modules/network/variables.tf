variable "vpc_name" {}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "public_subnet_cidrs" {
  type = list(string)
}