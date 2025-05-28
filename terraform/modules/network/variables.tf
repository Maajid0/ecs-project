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