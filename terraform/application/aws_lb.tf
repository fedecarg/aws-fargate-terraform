resource "aws_lb" "es-react-app-ecs-lb" {
  name     = "${local.resource_prefix}"
  internal = false

  security_groups = [
    "${aws_security_group.inbound.id}",
    "${aws_security_group.internal.id}",
  ]

  subnets = [
    "${aws_subnet.public.*.id}",
  ]

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "es-react-app-ecs-lb-tg" {
  port     = "80"
  protocol = "HTTP"

  target_type = "ip"
  vpc_id      = "${aws_vpc.es-react-app-ecs-vpc.id}"

  depends_on = [
    "aws_lb.es-react-app-ecs-lb",
  ]

  health_check {
    port                = "${var.app_port}"
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 30
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "${local.resource_prefix}"
  }
}

resource "aws_lb_listener" "es-react-app-ecs-lb-listener-http" {
  load_balancer_arn = "${aws_lb.es-react-app-ecs-lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.es-react-app-ecs-lb-tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "es-react-app-ecs-lb-listener-https" {
  load_balancer_arn = "${aws_lb.es-react-app-ecs-lb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${var.certificate_arn}"

  default_action {
    target_group_arn = "${aws_lb_target_group.es-react-app-ecs-lb-tg.arn}"
    type             = "forward"
  }
}
