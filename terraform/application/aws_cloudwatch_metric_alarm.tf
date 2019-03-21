resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${aws_ecs_service.service.name}-cpu-utilization-above-75"
  alarm_description   = "This alarm monitors ${aws_ecs_service.service.name} CPU utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "75"
  alarm_actions       = ["${aws_appautoscaling_policy.scale-up.arn}"]

  dimensions {
    ClusterName = "${aws_ecs_cluster.cluster.name}"
    ServiceName = "${aws_ecs_service.service.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${aws_ecs_service.service.name}-cpu-utilization-below-5"
  alarm_description   = "This alarm monitors ${aws_ecs_service.service.name} CPU utilization for scaling down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "5"
  alarm_actions       = ["${aws_appautoscaling_policy.scale-down.arn}"]

  dimensions {
    ClusterName = "${aws_ecs_cluster.cluster.name}"
    ServiceName = "${aws_ecs_service.service.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name          = "${aws_ecs_service.service.name}-memory-utilization-above-75"
  alarm_description   = "This alarm monitors ${aws_ecs_service.service.name} memory utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "75"
  alarm_actions       = ["${aws_appautoscaling_policy.scale-up.arn}"]

  dimensions {
    ClusterName = "${aws_ecs_cluster.cluster.name}"
    ServiceName = "${aws_ecs_service.service.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_low" {
  alarm_name          = "${aws_ecs_service.service.name}-memory-utilization-below-75"
  alarm_description   = "This alarm monitors ${aws_ecs_service.service.name} memory utilization for scaling down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "5"
  alarm_actions       = ["${aws_appautoscaling_policy.scale-down.arn}"]

  dimensions {
    ClusterName = "${aws_ecs_cluster.cluster.name}"
    ServiceName = "${aws_ecs_service.service.name}"
  }
}
