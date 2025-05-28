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
    Name = var.igw.name
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
