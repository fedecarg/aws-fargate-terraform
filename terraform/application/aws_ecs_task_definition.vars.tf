variable "container_memory" {
  description = "Amount of memory to assign each container"
}

variable "container_cpu" {
  description = "Amount of cpu resource to assign each container"
}

variable "container_image" {
  description = "Docker image name to be deployed"
  default     = "latest"
}
