resource "aws_ecs_task_definition" "ecs_task_example" {
  family                   = "example-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = <<EOF
  [
    {
        "name": "example-container",
        "image": "nginx-latest",
        "portMappings": [
            {
                "containerPort": 80,
                "protocol": "tcp"
            }
        ],
        "cpu": 256,
        "memory": 512,
        "essential": true
    }
  ]
  EOF
}

resource "aws_ecs_cluster" "ecs_cluster_example" {
  name = "example-cluster"
}

resource "aws_ecs_service" "ecs_service_example" {
  name            = "example-service"
  cluster         = aws_ecs_cluster.ecs_cluster_example.id
  task_definition = aws_ecs_task_definition.ecs_task_example.arn
  desired_count   = 1

}