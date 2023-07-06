resource "aws_instance" "app_server" {
  ami           = "ami-038056f5d3df2259d"
  instance_type = "t2.micro"
  depends_on    = aws_internet_gateway.igw


  tags = {
    Name = "EC2TestInstance"
  }
}