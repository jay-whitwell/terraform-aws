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

module "aws_vpc" {
  source = "./vpc"
}

module "route53" {
  source = "./route53"
}

module "ecs" {
  source = "./ecs"
}