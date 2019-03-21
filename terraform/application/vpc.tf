resource "aws_vpc" "es-react-app-ecs-vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${local.resource_prefix}-VPC"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.es-react-app-ecs-vpc.id}"
}
