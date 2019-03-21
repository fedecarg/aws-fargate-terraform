terraform {
  backend "s3" {
    encrypt = true
    bucket  = "${var.s3_bucket_state_storage_name}"
    region  = "${var.aws_region}"
    profile = "${var.aws_profile}"
  }
}
