provider "aws" {
  region = var.region
}


module "network" {
  source             = "./modules/network"
  vpc_cidr           = var.cidr_block
  vpc_name           = "demo-devlake-vpc"
  environment        = var.environment
  public_cidr_block  = var.public_subnet_cidrs
  private_cidr_block = var.private_subnet_cidrs
  azs                = var.availability_zones
  owner              = "demo-devlake-alb"
}




module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.network.vpc_id
  tags   = var.tags
}

module "devlake" {
  source         = "./modules/ec2"
  key_name       = var.key_name
  ami_name       = var.ami_id
  sg_id          = module.security_groups.web_sg_id
  vpc_name       = module.network.vpc_name
  public_subnets = module.network.public_subnets_id[1]
  instance_type  = var.instance_type
  project_name   = "demo-instance-devlake"
}



module "alb" {
  source                = "./modules/alb"
  name                  = "devlake-lb"
  security_group_id     = module.security_groups.web_sg_id
  subnet_ids            = module.network.public_subnets_id
  target_group_name     = "devlake-target-group"
  target_group_port     = 4000
  target_group_protocol = "HTTP"
  vpc_id                = module.network.vpc_id
  health_check_path     = "/"
  health_check_protocol = "HTTP"
  health_check_interval = 60
  health_check_timeout  = 10
  healthy_threshold     = 3
  unhealthy_threshold   = 5
  listener_port         = 80
  listener_protocol     = "HTTP"
  target_ids            = module.devlake.instance_id
  tags                  = var.tags
}
