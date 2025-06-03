variable "vpc_cidr" {}
variable "vpc_name" {}
variable "environment" {}
variable "public_cidr_block" { type = list(string) }
variable "private_cidr_block" { type = list(string) }
variable "azs" { type = list(string) }
variable "owner" {}
