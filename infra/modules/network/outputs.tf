output "vpc_id" {
  value = data.aws_vpc.this.id
}

output "private_subnets" {
  value = data.aws_subnets.private.ids
}

output "public_subnets" {
  value = data.aws_subnets.public.ids
}