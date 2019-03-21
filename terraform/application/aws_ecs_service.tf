resource "aws_ecs_service" "service" {
  name                               = "${local.resource_prefix}"
  cluster                            = "${aws_ecs_cluster.cluster.id}"
  task_definition                    = "${aws_ecs_task_definition.app.arn}"
  desired_count                      = "${local.minimum_container_amount}"
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  depends_on = ["aws_lb.es-react-app-ecs-lb", "aws_lb_target_group.es-react-app-ecs-lb-tg", "aws_security_group.internal"]

  network_configuration {
    subnets = [
      "${aws_subnet.private.*.id}",
    ]

    security_groups = ["${aws_security_group.internal.id}"]
  }

  load_balancer {
    target_group_arn = "${aws_lb_target_group.es-react-app-ecs-lb-tg.arn}"
    container_name   = "${local.resource_prefix}"
    container_port   = "${var.app_port}"
  }

  lifecycle {
    ignore_changes = ["desired_count"]
  }
}
