resource "aws_instance" "web-server" {
  ami               = "ami-0e3f80b3d2a794117"
  instance_type     = "t2.micro"
  depends_on        = [aws_internet_gateway.igw]
  availability_zone = "eu-west-2a"
  key_pair          = "access-key"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = <<EOF
    #!/bin/bash
    sudo apt update y
    sudo apt install apache2 -y
    sudo systemctl start apache2
    sudo bash -c "echo my first apache server > /var/www/html/index.html"
  EOF



  tags = {
    Name = "web-server"
  }
}