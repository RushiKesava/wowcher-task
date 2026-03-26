output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "ecs_sg" {
  value = aws_security_group.ecs_sg.id
}

output "alb_dns" {
  value = aws_lb.this.dns_name
}