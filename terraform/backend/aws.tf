provider "aws" {
  version = "~> 1.11"
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

output "aws_region" {
  value = "${var.aws_region}"
}

output "aws_profile" {
  value = "${var.aws_profile}"
}
