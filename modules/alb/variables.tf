variable "name" {
  description = "The name of the load balancer"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID for the load balancer"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
}

variable "target_group_protocol" {
  description = "The protocol for the target group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "health_check_path" {
  description = "The path for the health check"
  type        = string
}

variable "health_check_protocol" {
  description = "The protocol for the health check"
  type        = string
}

variable "health_check_interval" {
  description = "The interval for the health check"
  type        = number
}

variable "health_check_timeout" {
  description = "The timeout for the health check"
  type        = number
}

variable "healthy_threshold" {
  description = "The healthy threshold for the health check"
  type        = number
}

variable "unhealthy_threshold" {
  description = "The unhealthy threshold for the health check"
  type        = number
}

variable "listener_port" {
  description = "The port for the listener"
  type        = number
}

variable "listener_protocol" {
  description = "The protocol for the listener"
  type        = string
}

variable "target_ids" {
  description = "Name of target IDs for the target group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
