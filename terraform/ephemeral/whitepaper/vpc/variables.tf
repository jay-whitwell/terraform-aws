variable "subnet_prefix" {
  description = "The prefix for the subnet names"
  default     = "subnet"
  type        = string
}

variable "allowed_ip" {
  description = "The allowed ingress IP"
  type        = string
}