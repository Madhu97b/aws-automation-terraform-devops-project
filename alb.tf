//reference:- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb

//creating the alb resource

resource "aws_lb" "docker_alb" {
  name               = "Docker-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  //availability_zone we have mentioned in the subnets.tf file. So we are just mentioning the subnet id's here.

  enable_deletion_protection = false

  tags = {
    Name        = "Docker_alb"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

//search for aws_lb inside the official doc or in web.
