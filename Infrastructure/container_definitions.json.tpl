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
      { "name": "DB_PORT",     "value": "5432" },
      { "name": "DB_USER",     "value": "postgres" },
      { "name": "DB_PASSWORD", "value": "postgres" },
      { "name": "DB_NAME",     "value": "mydb" }
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