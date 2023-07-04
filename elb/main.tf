resource "aws_lb" "web_sever_elb" {
  name               = "web_server_elb_tf"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.lb_sg.id]
}