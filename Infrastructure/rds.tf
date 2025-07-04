resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.private.id, aws_subnet.private_b.id]

  tags = {
    Name = "main-db-subnet-group"
  }
}

resource "aws_db_parameter_group" "disable_ssl" {
  name        = "postgres-disable-ssl"
  family      = "postgres17"
  description = "Parameter group with SSL disabled"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "nestjs-postgres"
  engine = "postgres"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  username = "postgres"
  password = "postgres07"
  db_name = "mydb"
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot = true
  publicly_accessible = false
  multi_az = false
  storage_encrypted = true
  parameter_group_name = aws_db_parameter_group.disable_ssl.name
}