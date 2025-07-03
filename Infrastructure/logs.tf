resource "aws_cloudwatch_log_group" "nestjs" {
  name              = "/ecs/nestjs-app"
  retention_in_days = 7
}