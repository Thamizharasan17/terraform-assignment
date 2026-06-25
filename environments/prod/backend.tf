terraform {
  backend "s3" {
    bucket         = "terraform-assignment-state-thamizh"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
  }
}