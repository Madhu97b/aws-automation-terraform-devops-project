resource "aws_internet_gateway" "docker_igw" {

  vpc_id = aws_vpc.docker_vpc.id

  tags = {
    Name        = "Docker_IGW"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

