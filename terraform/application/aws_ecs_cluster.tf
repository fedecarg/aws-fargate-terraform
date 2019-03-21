resource "aws_ecs_cluster" "cluster" {
  name = "${local.resource_prefix}"
}
