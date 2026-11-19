//references:- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
//references:- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment

//we are going to create the target group for the alb and we will attach the instances to the target groups after creating the target group.

//target-group one with one instance attached.

resource "aws_lb_target_group" "docker_tg_1" {
  target_type = "instance"
  name        = "docker-alb-tg-1"
  protocol    = "HTTP"
  port        = 3000
  vpc_id      = aws_vpc.docker_vpc.id

  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name        = "docker_alb_tg_1"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

//Now we are going to attach the instances to the target group 

resource "aws_lb_target_group_attachment" "app1" {
  target_group_arn = aws_lb_target_group.docker_tg_1.arn
  target_id        = aws_instance.docker_ec2_1.id
  port             = 3000
}


//target-group second with second instance attached.

resource "aws_lb_target_group" "docker_tg_2" {
  target_type = "instance"
  name        = "docker-alb-tg-2"
  protocol    = "HTTP"
  port        = 3000
  vpc_id      = aws_vpc.docker_vpc.id

  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name        = "docker_alb_tg_2"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}


resource "aws_lb_target_group_attachment" "app2" {
  target_group_arn = aws_lb_target_group.docker_tg_2.arn
  target_id        = aws_instance.docker_ec2_2.id
  port             = 3000
}

