#!/bin/bash

# Exit if any command fails
set -e

# Update installed packages
dnf update -y

# Install Docker
dnf install -y docker

# Enable Docker service at boot
systemctl enable docker

# Start Docker service
systemctl start docker

# Add ec2-user to Docker group
usermod -aG docker ec2-user

# Verify Docker installation
docker --version

# Check Docker service status
systemctl status docker --no-pager
