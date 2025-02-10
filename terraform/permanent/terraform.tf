terraform {

  backend "s3" {
    bucket  = "jay-tfstate"
    key     = "permanent/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.64.0"
    }
  }

  required_version = "~>1.10.5"
}
