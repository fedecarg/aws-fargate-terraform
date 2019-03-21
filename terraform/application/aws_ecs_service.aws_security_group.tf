resource "aws_security_group" "internal" {
  name        = "${local.resource_prefix}-internal"
  description = "Allow internal traffic"
  vpc_id      = "${aws_vpc.es-react-app-ecs-vpc.id}"

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = ["${aws_security_group.inbound.id}"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags {
    Name = "${local.resource_prefix}-internal"
  }
}
