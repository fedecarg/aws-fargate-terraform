terraform {
  backend "s3" {
    encrypt = true
    bucket  = "example-app"
    region  = "us-east-1"
    profile = "federico"
  }
}

data "terraform_remote_state" "local" {
  backend = "local"

  config {
    path = "backend/terraform.tfstate"
  }
}

output "local-state" {
  value = "${data.terraform_remote_state.local.aws_ecr_repository_url}"
}
