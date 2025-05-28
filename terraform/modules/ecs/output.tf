output "ecs_cluster_id" {
  value = aws_ecs_cluster.tm_ecs_cluster.id
}

output "ecs_service" {
  value = aws_ecs_service.tm_service
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.tm_comp.arn
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role_v2.arn
}
