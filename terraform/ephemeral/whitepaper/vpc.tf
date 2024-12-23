module "vpc" {
  source = "./vpc"
  allowed_ip = var.allowed_ip
}