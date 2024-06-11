# Configuring the Backend

terraform {
  backend "s3" {
    bucket         = "lienge-group"
    key            = "key/terraform.tfstate"
    region         = "us-east-1"
    # dynamodb_table = "liengedb"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }

  }
}


provider "aws" {
  region = var.region[0]

}