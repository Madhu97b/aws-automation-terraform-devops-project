// Listener for the app1 with port 80

resource "aws_lb_listener" "app_1_listener" {
  protocol          = "HTTP"
  port              = 80
  load_balancer_arn = aws_lb.docker_alb.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.docker_tg_1.arn
  }
}

//Listener for the app2 with port 81

resource "aws_lb_listener" "app_2_listener" {
  protocol          = "HTTP"
  port              = 81
  load_balancer_arn = aws_lb.docker_alb.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.docker_tg_2.arn
  }
}

