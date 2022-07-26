# Create Database Subnet Group

resource "aws_db_subnet_group" "database-subnet-group" {
  name       = "database-subnets"
  subnet_ids = [aws_subnet.Private_Subnet_1.id,aws_subnet.Private_Subnet_2.id]
  description = "Subnet for Database Instance"

  tags = {
    Name = " Database subnets "
  }
}


#create a mysql rds instance
resource "aws_db_instance" "demo-mysql-db" {
  identifier           = "my-sql-database"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7.31"
  instance_class       = "db.t2.micro"
  port                 = "3306"
  db_subnet_group_name = aws_db_subnet_group.database-subnet-group.name
  name                 ="mydemodb" 
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  availability_zone    = "ap-south-1a" 
  deletion_protection   = true
  
  
  tags =  {
    Name ="Demo Mysql RDS Instance"
      
  }
}