resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "subnet-1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.main.id

  route {
    # Send all ipv4 traffic to the igw
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    # Send all ipv6 traffic to the igw
    ipv6_cidr_block = "::/0"
    # Apparently lets any subnet traffic out to the internet?
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main-route-table"
  }
}

# This creates an association between a subnet and the routing table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_network_interface" "web-server-nic" {
  subnet_id = aws_subnet.subnet-1.id
  # Assign the IP address for the ENI
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow-web-traffic.id]

  # We could assign this ENI to an EC2 instance now, but you
  # can do the opposite when creating the EC2 (i.e., give the EC2
  # the property of this ENI.)
}

resource "aws_eip" "eip-one" {
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.igw]
}
