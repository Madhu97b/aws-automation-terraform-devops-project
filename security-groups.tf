resource "aws_security_group" "alb_sg" {
  name        = "Docker_ALB_SG"
  description = "We are creating the SG for the ALB"
  vpc_id      = aws_vpc.docker_vpc.id

  tags = {
    Name        = "Docker_ALB_SG"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "Docker_EC2_SG"
  description = "We are creating the SG for the EC2"
  vpc_id      = aws_vpc.docker_vpc.id

  tags = {
    Name        = "Docker_EC2_SG"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

//ALB security group ingress rule for target group 1 which uses 80 port

resource "aws_vpc_security_group_ingress_rule" "alb_http_80" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "80"
  to_port           = "80"
  ip_protocol       = "tcp"
}

//ALB security group ingress rule for target group  which uses 81 port

resource "aws_vpc_security_group_ingress_rule" "alb_http_81" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "81"
  to_port           = "81"
  ip_protocol       = "tcp"
}

//ALB egress rule and its the ingress rule input for the ec2.

resource "aws_vpc_security_group_egress_rule" "alb_to_ec2" {

  security_group_id = aws_security_group.alb_sg.id

  referenced_security_group_id = aws_security_group.ec2_sg.id

  from_port = "3000"
  to_port   = "3000"

  ip_protocol = "tcp"
}

//EC2 ingress rule and which takes the input and reference from the alb egress rule

resource "aws_vpc_security_group_ingress_rule" "from_alb_to_ec2" {

  security_group_id = aws_security_group.ec2_sg.id

  referenced_security_group_id = aws_security_group.alb_sg.id

  from_port = "3000"
  to_port   = "3000"

  ip_protocol = "tcp"
}

//EC2 egress rule 

resource "aws_vpc_security_group_egress_rule" "ec2_outbound" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

//Here ip_protocol is -1 which means it includes all the ip protocols in it including udp, tcp ,etc.. And cidr_ipv4 why we are mentioned in egress rule of ec2 instead of ingress rule ?? The answer is inbound and outbound rules are stateful if we mentioned in any one also applicable for both.


