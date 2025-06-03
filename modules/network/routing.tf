resource "aws_route_table" "public-routing-table" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
  tags = {
    Name        = "${var.vpc_name}-Public-RT"
    environment = var.environment
  }
}

resource "aws_route_table" "private-routing-table" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name        = "${var.vpc_name}-Private-RT"
    environment = var.environment
  }
}

resource "aws_route_table_association" "public-subnets" {
  count          = length(local.new_public_cidr_block)
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index)
  route_table_id = aws_route_table.public-routing-table.id
}

resource "aws_route_table_association" "private-subnets" {
  count          = length(local.new_private_cidr_block)
  subnet_id      = element(aws_subnet.private-subnets.*.id, count.index)
  route_table_id = aws_route_table.private-routing-table.id
}