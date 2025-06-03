resource "aws_subnet" "private-subnets" {
  count                   = length(local.new_private_cidr_block)
  vpc_id                  = aws_vpc.demo-vpc.id
  map_public_ip_on_launch = false
  cidr_block              = element(local.new_private_cidr_block, count.index)
  availability_zone       = element(distinct(var.azs), count.index)

  tags = {
    Name        = "${var.vpc_name}-Private-Subnet-${count.index + 1}"
    environment = var.environment
  }
}