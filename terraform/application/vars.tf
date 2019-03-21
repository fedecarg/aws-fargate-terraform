variable "app_port" {
  description = "Port that docker image exposes"
}

variable "minimum_container_amount" {
  description = "Minimum amount of containers to run"
}

variable "maximum_container_amount" {
  description = "Maximum amount of containers to run"
}

variable "number_of_availability_zones" {
  description = "Number of availability zones"
}