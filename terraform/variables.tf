
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_key_pair" {}

variable "aws_private_key_pem" {}

variable "aws_region" {
  default = "us-west-2"
}

# t2.medium is minimum recommended setup for testing
variable "aws_instance_type" {
  default = "t2.medium"
}

variable "stackstorm_username" {
  default = "st2admin"
}

variable "stackstorm_password" {}
