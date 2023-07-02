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

resource "aws_route53_zone" "primary" {
  name = "yobbos.link"
}

resource "aws_route53_record" "nameservers" {
  allow_overwrite = true
  name            = "yobbos.link"
  ttl             = 3600
  type            = "NS"
  zone_id         = aws_route53_zone.primary.zone_id

  records         = aws_route53_zone.primary.name_servers
}

resource "aws_instance" "app_server" {
  ami           = "ami-038056f5d3df2259d"
  instance_type = "t2.micro"

  tags = {
    Name = "EC2TestInstance"
  }
}