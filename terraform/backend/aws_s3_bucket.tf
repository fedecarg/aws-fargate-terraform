resource "aws_s3_bucket" "state-storage" {
  bucket = "${var.s3_bucket_state_storage_name}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name = "Terraform remote state storage"
  }
}
