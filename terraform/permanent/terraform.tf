terraform {

  backend "s3" {
    bucket  = "jay-tfstate"
    key     = "terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = "~> 1.8.0"
}

