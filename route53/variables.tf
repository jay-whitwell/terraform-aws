variable "instance_public_ip" {
  description = "The IP of the EC2 instance"
  type        = string
  default     = null
}

variable "alb_public_ip" {
  description = "The public IP of the ALB"
  type        = string
  default     = null
}

variable "alb_dns_name" {
  description = "The DNS for the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "The ALB zone"
  type        = string
}