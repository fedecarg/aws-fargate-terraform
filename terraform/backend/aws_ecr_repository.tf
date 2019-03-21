resource "aws_ecr_repository" "repository" {
  name = "${var.ecr_repository_name}"
}

output "aws_ecr_repository_name" {
  value = "${aws_ecr_repository.repository.name}"
}

output "aws_ecr_repository_url" {
  value = "${aws_ecr_repository.repository.repository_url}"
}
