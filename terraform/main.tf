# Networking

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet1_cidr_value
  availability_zone = var.subnet1_availability_zone

  tags = {
    Name = var.subnet1_name
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr_value
  availability_zone = var.subnet2_availability_zone

  tags = {
    Name = var.subnet2_name
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet3_cidr_value
  availability_zone = var.subnet3_availability_zone

  tags = {
    Name = var.subnet3_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_table_cidrs
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

# ALB

module "alb" {
  source                    = "./modules/alb"
  alb_name                  = var.alb_name
  internal                  = var.internal
  load_balancer_type        = var.load_balancer_type
  security_groups           = [aws_security_group.sg.id]
  subnet_ids                = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
  enable_deletion_protection = var.enable_deletion_protection
  target_group_name         = "${var.alb_name}-tg"
  target_group_port         = var.target_group_port
  target_group_protocol     = var.target_group_protocol
  vpc_id                    = aws_vpc.main.id
  health_check_path         = var.health_check_path
  health_check_protocol     = var.health_check_protocol
  health_check_matcher      = var.health_check_matcher
  health_check_interval     = var.health_check_interval
  health_check_timeout      = var.health_check_timeout
  health_check_healthy_threshold   = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
  listener_port             = var.listener_port
  listener_protocol         = var.listener_protocol
  certificate_arn = module.acm.certificate_arn
}


output "alb_dns" {
  value = module.alb.alb_dns_name
}

output "alb_arn" {
  value = module.alb.alb_arn
}

# ECS

resource "aws_iam_role" "ecs_task_execution_role_v2" {
  name = var.ecs_task_execution_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags

}

module "ecs" {
  source = "./modules/ecs"

  ecs_cluster_name             = var.ecs_cluster_name
  ecs_task_family              = var.ecs_task_family
  ecs_network_mode             = var.ecs_network_mode
  ecs_cpu                      = var.ecs_cpu
  ecs_memory                   = var.ecs_memory
  ecs_container_image          = var.ecs_container_image
  container_name               = var.container_name
  ecs_container_cpu            = var.ecs_container_cpu
  ecs_container_memory         = var.ecs_container_memory
  ecs_container_port           = var.ecs_container_port
  ecs_container_host_port      = var.ecs_container_host_port
  ecs_service_name             = var.ecs_service_name
  ecs_launch_type              = var.ecs_launch_type

  ecs_task_requires_compatibilities = var.ecs_task_requires_compatibilities
  ecs_desired_count            = var.ecs_desired_count
  ecs_subnet_ids               = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
  ecs_assign_public_ip         = var.ecs_assign_public_ip
  ecs_task_execution_role      = aws_iam_role.ecs_task_execution_role_v2.arn
  ecs_task_execution_role_name = var.ecs_task_execution_role_name
  ecs_security_group_ids       = [aws_security_group.sg.id]
  alb_target_group_arn        = module.alb.target_group_arn
  alb_listener_arn            = module.alb.listener_arn
  vpc_id                      = aws_vpc.main.id
}


# Route53

module "route53" {
  source         = "./modules/route53"
  domain_name    = var.domain_name
  alb_dns_name   = module.alb.alb_dns_name
  alb_zone_id    = module.alb.alb_zone_id
}

# ACM

module "acm" {
  source                    = "./modules/acm"
  acm_domain_name           = var.acm_domain_name
  route53_zone_id           = var.route53_zone_id
  dns_ttl                   = var.dns_ttl
  validation_method         = var.validation_method
}
