locals {
  new_public_cidr_block  = distinct(var.public_cidr_block)
  new_private_cidr_block = distinct(var.private_cidr_block)
  vpcname                = join("-", [var.vpc_name, var.environment])

}