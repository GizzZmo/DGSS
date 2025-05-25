#!/bin/bash

# Update system packages
sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install docker.io -y
sudo systemctl enable --now docker

# Pull security backend container from AWS Registry
docker pull <AWS_CONTAINER_REGISTRY>/security-backend:latest

# Run security monitoring service
docker run -d -p 5000:5000 security-backend

# Configure firewall rules
sudo ufw allow 5000/tcp
