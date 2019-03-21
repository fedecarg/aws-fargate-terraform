variable "es_digital_hosted_zone" {
  description = "Hosted zone id of the route53 domain"
}

variable "app_name" {
  description = "Used for the prefix of .fedecarg.com in the route53 record"
}

variable "environment" {
  description = "Used to prefix app_name, ie (qa|dev|production)-(app_name).fedecarg.com in route53"
}
