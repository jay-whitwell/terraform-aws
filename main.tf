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

module "vpc" {
  source = "./vpc"
  jay_ip = var.jay_ip
}

module "ec2" {
  source = "./ec2"

  nic_id = module.vpc.nic_id
}