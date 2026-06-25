aws_region = "ap-south-1"

environment = "prod"

vpc_cidr = "10.0.0.0/16"

public_subnet_1_cidr  = "10.0.1.0/24"
public_subnet_2_cidr  = "10.0.2.0/24"

private_subnet_1_cidr = "10.0.11.0/24"
private_subnet_2_cidr = "10.0.12.0/24"

az1 = "ap-south-1a"
az2 = "ap-south-1b"

instance_type = "t3.small"

# Ubuntu LTS AMI
ami_id = "ami-006f82a1d5a27da54"

desired_capacity = 2
min_size         = 2
max_size         = 4