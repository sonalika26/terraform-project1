# Create Security Group for Apllication Load Balancer
resource "aws_security_group" "alb-security-group" {
  name        = "alb-security-groups"
  description = "Enable HTTP/Https access on Port80/443"
  vpc_id      = aws_vpc.my-VPC.id

  ingress {
    description      = "HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  ingress {
    description      = "HTTPS Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "alb-security-group"
  }
}

# Create Security Group for the Bastion Host

resource "aws_security_group" "ssh-security-group" {
  name        = "SSH Access"
  description = "Enable  SSH Access on Port 22 "
  vpc_id      = aws_vpc.my-VPC.id

  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  ingress {
    description      = "HTTPS Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["10.10.2.0/24"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["10.10.2.0/24"]
    
  }

  tags = {
    Name = "SSH-security-group"
  }
}

# Create Security Group for the WebServert

resource "aws_security_group" "webserver-security-group" {
  name        = "webserver"
  description = "Enable  HTTP/HTTPS Access on Port 80/443 via ALB and SSH on Port 22 via SSH SG "
  vpc_id      = aws_vpc.my-VPC.id

  ingress {
    description      = "HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp" 
    security_groups = ["${aws_security_group.alb-security-group.id}"]
   
  }

  ingress {
    description      = "HTTPS Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups = ["${aws_security_group.alb-security-group.id}"]
   
  }

  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = ["${aws_security_group.ssh-security-group.id}"]
   
  }



  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "webserver_security_group"
  }
}


# Create Security Group for the Database

resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "Enable  MYSQL Access on Port 3306 "
  vpc_id      = aws_vpc.my-VPC.id

  ingress {
    description      = "MYSQL Access"
    from_port        = 3306
    to_port          = 3306
    protocol         ="tcp"
    security_groups = ["${aws_security_group.webserver-security-group.id}"]
   
  }

  


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "Database_security_group"
  }
}
