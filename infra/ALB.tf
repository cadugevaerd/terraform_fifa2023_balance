resource "aws_lb" "alb_ecs_app" {
  name               = "alb-ecs-app"
  internal           = false
  security_groups    = [aws_security_group.ALB_Allow_Traffic.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb_ecs_app.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg_ip.arn
  }
}

resource "aws_lb_target_group" "app_tg_ip" {
  name        = "app-tg-ip"
  port        = 8501
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}

output "dns_name" {
  value = aws_lb.alb_ecs_app.dns_name
}