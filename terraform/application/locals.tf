locals = {
  resource_prefix = "${var.environment}-${var.app_name}"
  number_of_availability_zones = "${var.number_of_availability_zones != "" ? var.number_of_availability_zones : length(data.aws_availability_zones.available.names)}"
  minimum_container_amount     = "${var.minimum_container_amount != "" ? var.minimum_container_amount : local.number_of_availability_zones}"
  maximum_container_amount     = "${var.maximum_container_amount != "" ? var.maximum_container_amount : local.number_of_availability_zones}"
}


