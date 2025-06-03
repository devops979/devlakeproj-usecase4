resource "aws_lb" "devlake_lb" {
  name                       = var.name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.security_group_id]
  subnets                    = var.subnet_ids
  drop_invalid_header_fields = true

  tags = var.tags
}

resource "aws_lb_target_group" "devlake_tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }

  tags = var.tags
}

resource "aws_lb_listener" "devlake_listener" {
  load_balancer_arn = aws_lb.devlake_lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.devlake_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "devlake_tg_attachment" {
  target_group_arn = aws_lb_target_group.devlake_tg.arn
  target_id        = var.target_ids
  port             = var.target_group_port
}

