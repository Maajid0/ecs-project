variable "alb_name" {
  type = string
}

variable "internal" {
  type = bool
}

variable "load_balancer_type" {
  type    = string
  default = "application"
}

variable "security_groups" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "enable_deletion_protection" {
  type    = bool
  default = false
}

variable "target_group_name" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "health_check_protocol" {
  type    = string
  default = "HTTP"
}

variable "health_check_matcher" {
  type    = string
  default = "200-399"
}

variable "health_check_interval" {
  type    = number
  default = 30
}

variable "health_check_timeout" {
  type    = number
  default = 5
}

variable "health_check_healthy_threshold" {
  type    = number
  default = 2
}

variable "health_check_unhealthy_threshold" {
  type    = number
  default = 2
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "listener_protocol" {
  type    = string
  default = "HTTP"
}

variable "certificate_arn" {
  type    = string
  default = ""
  description = "ARN of ACM certificate to use for HTTPS listener. If empty, HTTPS listener will not be created."
}
