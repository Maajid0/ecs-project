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

variable "ecs_subnet_ids" {
  description = "List of subnet IDs for ECS service networking"
  type        = list(string) 
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

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the ECS service will be deployed"
}

variable "alb_listener_arn" {
  type = string
}

variable "alb_target_group_arn" {
  type = string
}

variable "ecs_security_group_ids" {
  type = string
  description = "List of ECS security group IDs"
}

variable "ecs_launch_type" {
  type = string
  description = "The launch type used for the ECS Service"
}