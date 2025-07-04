[
  {
    "name": "nestjs-app",
    "image": "${image}",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000,
        "protocol": "tcp"
      }
    ],
    "environment": [
      { "name": "NODE_ENV",    "value": "production" },
      { "name": "DB_HOST",     "value": "${db_host}" },
      { "name": "DB_PORT",     "value": "${db_port}" },
      { "name": "DB_USER",     "value": "${db_user}" },
      { "name": "DB_PASSWORD", "value": "${db_password}" },
      { "name": "DB_NAME",     "value": "${db_name}" }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/nestjs-app",
        "awslogs-region": "eu-north-1",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]