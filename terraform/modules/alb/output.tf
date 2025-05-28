output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.main.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_security_groups" {
  description = "Security groups associated with the ALB"
  value       = aws_lb.main.security_groups
}

output "target_group_arn" {
  description = "The ARN of the ALB Target Group"
  value       = aws_lb_target_group.main.arn
}

output "target_group_name" {
  description = "The name of the ALB Target Group"
  value       = aws_lb_target_group.main.name
}

output "listener_arn" {
  description = "The ARN of the ALB Listener"
  value       = aws_lb_listener.https.arn
}

output "alb_zone_id" {
  value = aws_lb.main.zone_id
  description = "Zone ID of the ALB"
}
