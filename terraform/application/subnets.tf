# PUBLIC
resource "aws_subnet" "public" {
  count                   = "${local.number_of_availability_zones}"
  vpc_id                  = "${aws_vpc.es-react-app-ecs-vpc.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, (count.index * 10))}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "${local.resource_prefix}-${element(data.aws_availability_zones.available.names, count.index)}-public"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.es-react-app-ecs-vpc.id}"

  tags {
    Name = "${local.resource_prefix}-public"
  }
}

resource "aws_route" "internet" {
  route_table_id         = "${aws_route_table.public.id}"
  gateway_id             = "${aws_internet_gateway.gateway.id}"
  destination_cidr_block = "0.0.0.0/0"

  depends_on = ["aws_internet_gateway.gateway", "aws_route_table.public"]
}

resource "aws_route_table_association" "public" {
  count          = "${local.number_of_availability_zones}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_main_route_table_association" "public" {
  vpc_id         = "${aws_vpc.es-react-app-ecs-vpc.id}"
  route_table_id = "${aws_route_table.public.id}"
}

# PRIVATE
resource "aws_subnet" "private" {
  count                   = "${local.number_of_availability_zones}"
  vpc_id                  = "${aws_vpc.es-react-app-ecs-vpc.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, (count.index * 10) + 1)}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "${local.resource_prefix}-${element(data.aws_availability_zones.available.names, count.index)}-private"
  }
}

resource "aws_route_table" "private" {
  count  = "${local.number_of_availability_zones}"
  vpc_id = "${aws_vpc.es-react-app-ecs-vpc.id}"

  tags {
    Name = "${local.resource_prefix}-${element(data.aws_availability_zones.available.names, count.index)}-private"
  }
}

resource "aws_route" "private-route" {
  count                  = "${local.number_of_availability_zones}"
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private-route-table" {
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  count          = "${local.number_of_availability_zones}"
}
