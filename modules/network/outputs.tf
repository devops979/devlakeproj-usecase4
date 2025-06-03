output "vpc_name" {
  value = lower(local.vpcname)
}

output "vpc_id" {
  value = aws_vpc.demo-vpc.id
}

output "environment" {
  value = var.environment
}

output "public_subnets_id" {
  value = aws_subnet.public-subnets.*.id
}

output "private_subnets_id" {
  value = aws_subnet.private-subnets.*.id
}

# output public_subnets_id_1 {
#   value       = "${aws_subnet.public-subnets.0.id}"
# }

output "private_route_table_ids" {
  value = aws_route_table.private-routing-table.*.id
}
