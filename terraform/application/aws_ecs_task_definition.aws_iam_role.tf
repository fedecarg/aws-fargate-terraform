resource "aws_iam_role_policy" "task_definition_executor_role_policy" {
  name = "${local.resource_prefix}"
  role = "${aws_iam_role.executor-role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "executor-role-policy-document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "executor-role" {
  name = "${local.resource_prefix}-task-definition"

  assume_role_policy = "${data.aws_iam_policy_document.executor-role-policy-document.json}"
}
