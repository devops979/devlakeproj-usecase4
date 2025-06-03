output "instance_id" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.web-servers.id
}

output "public_ip" {
  value = aws_instance.web-servers.public_ip
}