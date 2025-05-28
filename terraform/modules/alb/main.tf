resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "main" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    matcher             = var.health_check_matcher
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
