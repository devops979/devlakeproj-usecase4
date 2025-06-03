resource "aws_vpc" "demo-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = lower(local.vpcname)
    Owner       = var.owner
    environment = var.environment
  }
}


resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = lower("${local.vpcname}-IGW")
  }
}