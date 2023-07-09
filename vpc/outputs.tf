output "igw" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw
}

output "nic_id" {
  description = "The ID of the NIC for the EC2 instance"
  value       = aws_network_interface.web-server-nic.id
}