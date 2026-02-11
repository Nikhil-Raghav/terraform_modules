variable "region" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "ami" {}
variable "instance_type" {}
variable "common_tags" {
  type = map(string)
}