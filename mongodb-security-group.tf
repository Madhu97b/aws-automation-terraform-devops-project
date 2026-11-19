//security group for the mongodb
resource "aws_security_group" "mongodb_sg" {
  name        = "mongodb_sg"
  description = "Allowing the traffic from the EC2 instance"
  vpc_id      = aws_vpc.docker_vpc.id

  tags = {
    Name        = "Mongodb_sg"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

//Inbound rules for the mongodb (ingress rules) 

resource "aws_vpc_security_group_ingress_rule" "mongodb_ingress_rule" {

  security_group_id = aws_security_group.mongodb_sg.id

  //Taking the reference of the sg from the ec2 instance 
  referenced_security_group_id = aws_security_group.ec2_sg.id

  from_port   = "27017"
  to_port     = "27017"
  ip_protocol = "tcp"
}

//Outbound rules for the mongodb (egress rules)

resource "aws_vpc_security_group_egress_rule" "mongodb_egress_rule" {

  security_group_id = aws_security_group.mongodb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

