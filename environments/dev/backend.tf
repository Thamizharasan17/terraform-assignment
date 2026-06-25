terraform {
  backend "s3" {
    bucket         = "terraform-assignment-state-thamizh"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
  }
}