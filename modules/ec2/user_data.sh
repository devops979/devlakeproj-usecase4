#!/bin/bash
set -e

# Update system packages
apt-get update -y
apt-get upgrade -y

# Install prerequisites
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common

# Add Docker’s official GPG key and set up the repository
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
    gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
    "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" |
    tee /etc/apt/sources.list.d/docker.list >/dev/null

# Install Docker
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable Docker service and add ubuntu user to docker group
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

# Install legacy Docker Compose CLI (optional but compatible with docker-compose.yml)
curl -L "https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Create project directory
mkdir -p /home/ubuntu/devlake

# Create docker-compose.yml for DevLake
cat >/home/ubuntu/devlake/docker-compose.yml <<'EOF'
version: '3'
 
services:
  mysql:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: lake
      MYSQL_USER: merico
      MYSQL_PASSWORD: merico
    volumes:
      - mysql-data:/var/lib/mysql
    ports:
      - "3306:3306"
 
  lake:
    image: mericodev/devlake:latest
    depends_on:
      - mysql
    ports:
      - "8080:8080"
 
  config-ui:
    image: mericodev/devlake-config-ui:latest
    depends_on:
      - lake
    ports:
      - "4000:4000"
 
  grafana:
    image: mericodev/devlake-dashboard:latest
    ports:
      - "3002:3000"
    volumes:
      - grafana-storage:/var/lib/grafana
    environment:
      GF_SERVER_ROOT_URL: "http://0.0.0.0:4000/grafana"
      GF_USERS_DEFAULT_THEME: "light"
      MYSQL_URL: mysql:3306
      MYSQL_DATABASE: lake
      MYSQL_USER: merico
      MYSQL_PASSWORD: merico
    depends_on:
      - mysql
 
volumes:
  mysql-data:
  grafana-storage:
EOF

# Start DevLake
cd /home/ubuntu/devlake
docker-compose up -d

echo "Docker and DevLake installation completed on Ubuntu."
