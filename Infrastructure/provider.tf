terraform {
  backend "s3" {
    bucket         = "terraform-backend-staj"
    key            = "lab08/infrastructure/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locking-staj"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}