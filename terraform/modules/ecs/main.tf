resource "aws_ecs_cluster" "tm_ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "tm_comp" {
  family                   = var.ecs_task_family
  requires_compatibilities = var.ecs_task_requires_compatibilities
  task_role_arn            = aws_iam_role.ecs_task_execution_role_v2.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role_v2.arn
  network_mode             = var.ecs_network_mode
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.ecs_container_image
      cpu       = var.ecs_container_cpu
      memory    = var.ecs_container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.ecs_container_port
          hostPort      = var.ecs_container_host_port
        }
      ]
    }
  ])
}

resource "aws_security_group" "ecs_sg" {
  name        = var.security_group_name
  description = "Security group for ECS service"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ecs_container_port
    to_port     = var.ecs_container_port
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress_cidr_block]
  }
}

resource "aws_ecs_service" "tm_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.tm_ecs_cluster.id
  task_definition = aws_ecs_task_definition.tm_comp.arn
  desired_count   = var.ecs_desired_count
  launch_type     = var.ecs_launch_type

  network_configuration {
    subnets         = var.ecs_subnet_ids
    security_groups = [var.ecs_security_group_ids]
    assign_public_ip = var.ecs_assign_public_ip
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.ecs_container_port
  }
  
  depends_on = [
  aws_iam_role_policy_attachment.ecs_execution_policy_attachment,
  ]

}


resource "aws_iam_role" "ecs_task_execution_role_v2" {
  name = var.ecs_task_execution_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Effect    = "Allow",
        Sid       = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_task_execution_role_v2.name
}
