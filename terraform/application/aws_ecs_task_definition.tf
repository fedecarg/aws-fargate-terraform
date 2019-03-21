data "template_file" "aws_ecs_task_definitions" {
  template = "${file("application/aws_ecs_task_definition.tpl")}"

  vars {
    resource_prefix = "${local.resource_prefix}"
    container_image  = "${data.terraform_remote_state.local.aws_ecr_repository_url}:${var.container_image}"
    container_port   = "${var.app_port}"
    container_cpu    = "${var.container_cpu}"
    container_memory = "${var.container_memory}"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${local.resource_prefix}"
  container_definitions    = "${data.template_file.aws_ecs_task_definitions.rendered}"
  network_mode             = "awsvpc"
  cpu                      = "${var.container_cpu}"
  memory                   = "${var.container_memory}"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "${aws_iam_role.executor-role.arn}"

  depends_on = [
    "aws_iam_role.executor-role",
  ]
}
