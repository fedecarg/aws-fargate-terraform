resource "aws_iam_role_policy" "policy" {
  name = "${local.resource_prefix}"
  role = "${aws_iam_role.service.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "elasticloadbalancing:Describe*",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "ec2:Describe*",
        "ec2:AuthorizeSecurityGroupIngress",
        "logs:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "ecs-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

output "ecs-assume-role-policy" {
  value = "${data.aws_iam_policy_document.ecs-assume-role-policy.json}"
}

resource "aws_iam_role" "service" {
  name = "${local.resource_prefix}-service"

  assume_role_policy = "${data.aws_iam_policy_document.ecs-assume-role-policy.json}"
}
