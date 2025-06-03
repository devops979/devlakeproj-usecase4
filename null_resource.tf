resource "null_resource" "install_devlake" {
  triggers = {
    # Re-run if instance IP changes
    instance_id = module.devlake.instance_id
  }

  connection {
    type        = "ssh"
    host        = module.devlake.public_ip
    user        = "ubuntu"
    private_key = file("/mnt/c/Users/anilc/Downloads/pem_files/devops-tools.pem")
    timeout     = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      # Install Docker (official method)
      "sudo apt-get update -y",
      "sudo apt-get install -y ca-certificates curl gnupg",
      "sudo install -m 0755 -d /etc/apt/keyrings",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
      "sudo chmod a+r /etc/apt/keyrings/docker.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update -y",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",

      # Post-install setup
      "sudo usermod -aG docker ubuntu",
      "sudo systemctl enable docker",

      # Clone and launch DevLake
      "git clone https://github.com/devops979/devlakeproj-usecase4.git /home/ubuntu/devlake",
      "cd /home/ubuntu/devlake && sudo docker compose up -d",

      # Ensure the user has immediate docker permissions without relogin
      "sudo chmod 666 /var/run/docker.sock"
    ]
  }

  # Wait for EC2 to be fully ready
  depends_on = [module.devlake]
}