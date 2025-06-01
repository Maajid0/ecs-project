# Networking

module "networking" {
  source = "./modules/network"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  subnet1_name = var.subnet1_name
  subnet2_name = var.subnet2_name
  subnet3_name = var.subnet3_name
  subnet1_cidr_value = var.subnet1_cidr_value
  subnet2_cidr_value = var.subnet2_cidr_value
  subnet3_cidr_value = var.subnet3_cidr_value
  route_table_cidrs = var.route_table_cidrs
  route_table_name = var.route_table_name
  security_group_name = var.security_group_name
  security_group_description = var.security_group_description
  subnet1_availability_zone = var.subnet1_availability_zone
  subnet2_availability_zone = var.subnet2_availability_zone
  subnet3_availability_zone = var.subnet3_availability_zone
  igw_name = var.igw_name
}

# ALB

module "alb" {
  source                    = "./modules/alb"
  alb_name                  = var.alb_name
  internal                  = var.internal
  load_balancer_type        = var.load_balancer_type
  security_groups           = module.networking.security_group_id
  subnet_ids                = module.networking.public_subnet_ids
  enable_deletion_protection = var.enable_deletion_protection
  target_group_name         = "${var.alb_name}-tg"
  target_group_port         = var.target_group_port
  target_group_protocol     = var.target_group_protocol
  vpc_id                    = module.networking.vpc_id
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

# ECS

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
  ecs_subnet_ids               = module.networking.public_subnet_ids
  ecs_assign_public_ip         = var.ecs_assign_public_ip
  ecs_task_execution_role_name = var.ecs_task_execution_role_name
  ecs_security_group_ids       = module.networking.security_group_id
  alb_target_group_arn        = module.alb.target_group_arn
  alb_listener_arn            = module.alb.listener_arn
  vpc_id                      = module.networking.vpc_id
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
