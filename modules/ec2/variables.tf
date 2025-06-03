
variable "ami_name" {
  description = "AMI name for EC2 instances"
  type        = string
}

variable "instance_type" {}
variable "key_name" {}
variable "public_subnets" {}
variable "sg_id" {}
variable "vpc_name" {}
#variable elb_listener {}
#variable "iam_instance_profile" {
#  description = "IAM instance profile for EC2 instances"
#  type        = string
#  default     = ""
#}
variable "project_name" {}

variable "associate_public_ip_address" {
  description = "Associate public IP address with EC2 instances"
  type        = bool
  default     = false

}

variable "user_data" {
  description = "user_data scripts"
  type        = string
  default     = ""

}

variable "volume_size" {
  description = "Size of the root block device in GB"
  type        = number
  default     = 30
}
variable "volume_type" {
  description = "Type of the root block device"
  type        = string
  default     = "gp3"
}