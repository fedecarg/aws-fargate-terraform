resource "aws_nat_gateway" "nat" {
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  count         = "${local.number_of_availability_zones}"

  depends_on = ["aws_internet_gateway.gateway", "aws_eip.nat"]
}
