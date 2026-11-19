//01. Private route table
resource "aws_route_table" "private_rt" {

  vpc_id = aws_vpc.docker_vpc.id

  tags = {
    Name        = "Private route table"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

//02. Route through NAT

resource "aws_route" "private_internet_route" {

  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.docker_nat.id
}

//03. Private subnet association with private route table

resource "aws_route_table_association" "private_subnet_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet_1.id
}

