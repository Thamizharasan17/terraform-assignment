variable "aws_region" {}
variable "environment" {}

variable "vpc_cidr" {}

variable "public_subnet_1_cidr" {}
variable "public_subnet_2_cidr" {}

variable "private_subnet_1_cidr" {}
variable "private_subnet_2_cidr" {}

variable "az1" {}
variable "az2" {}

variable "instance_type" {}
variable "ami_id" {}

variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}