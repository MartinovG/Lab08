resource "aws_ecs_cluster" "main" {
  name = "lab08-staj"
}

resource "aws_ecs_task_definition" "nestjs" {
  family = "nestjs-task"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  container_definitions = jsonencode([
    {
      name = "nestjs-app"
      image = "467198624662.dkr.ecr.eu-north-1.amazonaws.com/imagecontainer"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol = "tcp"
        }
      ]
       environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = "/ecs/nestjs-app"
          awslogs-region = "eu-north-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
  depends_on = [aws_cloudwatch_log_group.nestjs]
}

resource "aws_ecs_service" "nestjs" {
  name = "nestjs-service"
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nestjs.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
    subnets = [aws_subnet.public.id]
    security_groups = [aws_security_group.main.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nestjs.arn
    container_name = "nestjs-app"
    container_port = 3000
  }

  depends_on = [aws_lb_listener.http]
}