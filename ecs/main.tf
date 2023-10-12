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
    }
  ])
}

resource "aws_ecs_service" "my_service" {
  name            = "my-nginx-service"
  cluster         = aws_ecs_cluster.php-cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.ecs_subnet_a.id]
    security_groups  = [aws_security_group.ecs_instance_sg.id]
    assign_public_ip = true
  }
}