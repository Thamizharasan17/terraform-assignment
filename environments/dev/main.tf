//VPC module

module "vpc" {
  source = "../../modules/vpc"

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr

  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr

  az1 = var.az1
  az2 = var.az2
}

//SG module

module "security_group" {
  source = "../../modules/security-group"

  environment = var.environment
  vpc_id      = module.vpc.vpc_id
}

//ALB module

module "alb" {
  source = "../../modules/alb"

  environment = var.environment

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

  alb_sg_id = module.security_group.alb_sg_id
}

//ASG module

module "asg" {
  source = "../../modules/asg"

  environment = var.environment

  ami_id = var.ami_id

  instance_type = var.instance_type

  ec2_sg_id = module.security_group.ec2_sg_id

  private_subnet_ids = module.vpc.private_subnet_ids

  target_group_arn = module.alb.target_group_arn

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
}