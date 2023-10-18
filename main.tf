terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}

module "ecs" {
  source = "./ecs"
}

module "ecr" {
  source = "./ecr"
}

module "route53" {
  source = "./route53"
  // instance_public_ip = module.ec2.instance_public_ip 
  alb_dns_name = module.ecs.alb_dns_name
  alb_zone_id  = module.ecs.alb_zone_id
}