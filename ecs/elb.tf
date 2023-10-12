resource "aws_alb" "ecs_alb" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application" // We want the ALB here, not ELB
  subnets            = [aws_subnet.ecs_subnet_a.id, aws_subnet.ecs_subnet_b.id]
  security_groups    = [aws_security_group.alb_sg.id]
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.ecs_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "front_end" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ecs_vpc.id
  target_type = "ip"
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.ecs_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}   