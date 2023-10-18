resource "aws_ecs_cluster" "php-cluster" {
  name = "my-nginx-cluster"
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    "name" : "nginx",
    "image" : "nginx:latest",
    "portMappings" : [
      {
        "containerPort" : 80,
        "hostPort" : 80,
        "protocol" : "tcp"
      }
    ],
    "essential" : true,
    "healthCheck" : {
      "command" : ["CMD-SHELL", "curl -f http://localhost/ || exit 1"], # health check command for NGINX
      "interval" : 30,
      "timeout" : 10,
      "retries" : 3
    }
    }
  ])
}

resource "aws_ecs_service" "my_service" {
  name            = "nginx"
  cluster         = aws_ecs_cluster.php-cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.ecs_subnet_a.id]
    security_groups  = [aws_security_group.ecs_instance_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.front_end.arn
    container_name   = "nginx"
    container_port   = 80
  }
}