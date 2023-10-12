resource "aws_vpc" "ecs_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ecs_vpc"
  }
}

resource "aws_subnet" "ecs_subnet_a" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ecs_subnet_a"
  }
}

resource "aws_subnet" "ecs_subnet_b" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "ecs_subnet_b"
  }
}

resource "aws_internet_gateway" "ecs_igw" {
  vpc_id = aws_vpc.ecs_vpc.id

  tags = {
    Name = "ecs_igw"
  }
}

resource "aws_route_table" "ecs_route_table" {
  vpc_id = aws_vpc.ecs_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs_igw.id
  }

  tags = {
    Name = "ecs-route-table"
  }
}

resource "aws_route" "ecs_route" {
  route_table_id         = aws_route_table.ecs_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ecs_igw.id
}

# This creates an association between a subnet and the routing table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.ecs_subnet_a.id
  route_table_id = aws_route_table.ecs_route_table.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.ecs_subnet_b.id
  route_table_id = aws_route_table.ecs_route_table.id
}

resource "aws_security_group" "ecs_instance_sg" {
  vpc_id      = aws_vpc.ecs_vpc.id
  name        = "ecs_instance_sg"
  description = "ECS Instance Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
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

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs_sg"
  }
}

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.ecs_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "main"
  }
}