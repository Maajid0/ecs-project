# Networking

variable "vpc_name" {
  type = string 
  description = "The name of the vpc"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet1_name" {
  type = string
  description = "The name of subnet 1"
}

variable "subnet2_name" {
  type = string
  description = "The name of subnet 2"
}

variable "subnet3_name" {
  type = string
  description = "The name of subnet 3"
}

variable "subnet1_cidr_value" {
  type        = string
  description = "CIDR value for subnet 1"
  default     = "10.0.1.0/24"
}

variable "subnet2_cidr_value" {
  type = string
  description = "CIDR value for subnet 2"
  default     = "10.0.2.0/24"
}

variable "subnet3_cidr_value" {
  type = string
  description = "CIDR value for subnet 3"
  default     = "10.0.3.0/24"
}

variable "route_table_cidrs" {
    description = "CIDR block for the route table"
    default     = "0.0.0.0/0"
}

variable "route_table_name" {
  type = string
  description = "The name of the route table"
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group"
  default     = "ecs-sg"
}


variable "security_group_description" {
  type = string
  description = "Description of the security group"
}

variable "subnet1_availability_zone" {
type = string
description = "The availability zone for subnet 1"
}

variable "subnet2_availability_zone" {
  type = string
  description = "The availability zone for subnet 2"
}

variable "subnet3_availability_zone" {
  type = string
  description = "The availability zone for subnet 3"
}

variable "igw_name" {
  type = string
  description = "The name of the internet gateway"
}

# ALB

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


# ECS 

variable "ecs_cluster_name" {
  type        = string 
  description = "The name of the ECS cluster"
}

variable "ecs_task_family" {
  description = "The family name of the ECS task definition"
  type        = string
  default     = "tm-comp"
}

variable "ecs_network_mode" {
  description = "The Docker networking mode to use for the containers in the task"
  type        = string
  default     = "awsvpc"
}

variable "ecs_cpu" {
  type    = string
  default = "256"
}

variable "ecs_memory" {
  type    = string
  default = "512"
}

variable "ecs_container_image" {
  description = "The Docker image for the container (ECR repository URL + image tag)"
  type        = string
  default     = "public.ecr.aws/h8u9a9y8/tm-comp:latest"
}

variable "container_name" {
  type        = string
  description = "The name of the container"
}

variable "ecs_container_cpu" {
  description = "The number of CPU units reserved for the container"
  type        = number
  default     = 256
}

variable "ecs_container_memory" {
  description = "The amount of memory (in MiB) reserved for the container"
  type        = number
  default     = 512
}

variable "ecs_container_port" {
  description = "The port on the container to associate with the load balancer or host"
  type        = number
  default     = 3000
}

variable "ecs_container_host_port" {
  description = "The port on the host container should bind to"
  type        = number
  default     = 3000
}

variable "aws_region" {
  description = "AWS region where resources are deployed"
  type        = string
  default     = "eu-west-2"
}

variable "ecs_service_name" {
  type        = string
  description = "The name of the ECS service"
}

variable "ecs_launch_type" {
  type = string
  description = "The launch type used for the ECS Service"
}

variable "ecs_task_requires_compatibilities" {
  description = "The list of ECS task launch types"
  type        = list(string)
  default     = ["FARGATE"]
}


variable "ecs_desired_count" {
  description = "Number of container instances to run"
  type        = number
  default     = 2
}

variable "ecs_assign_public_ip" {
  description = "Whether to assign public IP to the task"
  type        = bool
  default     = false
}

variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution role"
  type        = string
}



# Route53

variable "domain_name" {
  description = "Domain name"
  type        = string
}

# ACM

variable "acm_domain_name" {
  description = "Domain name for ACM certificate"
  type        = string
  default     = "tm.maajid.co.uk"  
}

variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID to create validation records"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "validation_method" {
    type = string
    description = "The validation method used for the ACM certificate"
}

variable "dns_ttl" {
  type = number
  description = "TTL for DNS records"
}