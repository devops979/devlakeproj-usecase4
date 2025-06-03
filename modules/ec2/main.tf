resource "aws_instance" "web-servers" {
  ami                         = var.ami_name
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name
  root_block_device {
    volume_size = var.volume_size # <-- increase this
    volume_type = var.volume_type
  }
  user_data = templatefile("${path.module}/user_data.sh", {})
  tags = {
    Name = "${var.project_name}"
  }
}


