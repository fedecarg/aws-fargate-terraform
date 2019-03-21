# IF THIS CHANGES WE NEED TO ADD THE NEW IPS TO BACKEND AKAMAI WHITELIST
resource "aws_eip" "nat" {
  vpc   = true
  count = "${length(data.aws_availability_zones.available.names)}"

  lifecycle {
    prevent_destroy = true
  }
}
