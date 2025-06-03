resource "aws_subnet" "public-subnets" {
  count             = length(local.new_public_cidr_block)
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = element(local.new_public_cidr_block, count.index)
  availability_zone = element(distinct(var.azs), count.index)

  tags = {
    Name        = "${var.vpc_name}-Public-Subnet-${count.index + 1}"
    environment = var.environment
  }
}