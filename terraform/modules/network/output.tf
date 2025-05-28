output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id,
    aws_subnet.subnet3.id
  ]
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

output "security_group_id" {
  description = "The ID of the main security group"
  value       = aws_security_group.sg.id
}
