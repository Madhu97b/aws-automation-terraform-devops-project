resource "aws_route_table" "docker_rt" {

  vpc_id = aws_vpc.docker_vpc.id

  tags = {
    Name        = "Docker_RT"
    Environment = "Learning"
    Managed_By  = "Terraform"
  }
}

resource "aws_route" "public_route" {

  route_table_id = aws_route_table.docker_rt.id

  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.docker_igw.id

}

resource "aws_route_table_association" "subnet_1_association" {

  subnet_id = aws_subnet.public_subnet_1.id

  route_table_id = aws_route_table.docker_rt.id

}

resource "aws_route_table_association" "subnet_2_association" {

  subnet_id = aws_subnet.public_subnet_2.id

  route_table_id = aws_route_table.docker_rt.id

}




