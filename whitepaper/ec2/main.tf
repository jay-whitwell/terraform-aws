resource "aws_instance" "web-server" {
  ami               = "ami-0eb260c4d5475b901"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-2a"
  key_name          = "access-key"

  network_interface {
    device_index         = 0
    network_interface_id = var.nic_id
  }

  user_data = <<EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo bash -c "echo my first apache server > /var/www/html/index.html"
  EOF

  tags = {
    Name = "web-server"
  }
}