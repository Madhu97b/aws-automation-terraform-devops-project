resource "aws_eip" "nat_eip" {

  //To assign a elastic_ip for the nat_gateway we are taking the vpc as the refer   ence here
  domain = "vpc"

  tags = {
    Name        = "Elastic_ip_vpc_nat"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

resource "aws_nat_gateway" "docker_nat" {
  //allocation_ip is the elastic ip which is assigned for the nat gateway

  //subnet_id is used because nat gateway will get the internet from the public s   ubnet even if the its private.

  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name        = "Nat_gateway"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }

  //depends_on is used,Because internet_gateway_needs to be created before the n    at_gateway.
  depends_on = [
    aws_internet_gateway.docker_igw
  ]
}
