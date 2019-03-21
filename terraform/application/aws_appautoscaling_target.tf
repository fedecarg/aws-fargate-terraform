resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = "${local.maximum_container_amount}"
  min_capacity       = "${local.minimum_container_amount}"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [
    "aws_ecs_service.service",
  ]
}
