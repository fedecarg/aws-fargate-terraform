provider "aws" {
  version = "~> 1.19"
  region  = "${var.aws_region}"
  profile = "federico"
}

output "aws_region" {
  value = "${var.aws_region}"
}
