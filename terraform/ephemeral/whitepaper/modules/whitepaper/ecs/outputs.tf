output "alb_dns_name" {
  description = "The DNS name for the ALB"
  value       = aws_alb.ecs_alb.dns_name
}

output "alb_zone_id" {
  description = "The ALB zone"
  value       = aws_alb.ecs_alb.zone_id
}