output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "route53_primary_zone_id" {
  description = "The primary ID for the Route 53 zone"
  value       = aws_route53_zone.primary.name_servers
}