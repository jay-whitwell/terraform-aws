output "name_servers" {
  description = "The name servers from the Hosted Zonee"
  value       = aws_route53_zone.primary.name_servers
}