# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
#CREATE VPC 

resource "aws_vpc" "my-VPC" {
  cidr_block       = "${var.vpc-cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

#CREATE Internet Gateway and Attach it to VPC
#Terraform aws create internet gateway

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-VPC.id

  tags = {
    Name = "my-igw"
  }
}

#CREATE Public Subnet 
resource "aws_subnet" "Public_subnet_1" {
  vpc_id     = aws_vpc.my-VPC.id
  cidr_block = "${var.Public_subnet_1-cidr}"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "Public_subnet_2" {
  vpc_id     = aws_vpc.my-VPC.id
  cidr_block = "${var.Public_subnet_2-cidr}"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2"
  }
}


# Create Route Table and Add Public Route

resource "aws_route_table" "Public_route_table" {
  vpc_id = aws_vpc.my-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  
  tags = {
    Name = " Public Route Table"
  }
}

# Associate Public Subnet 1 to Public Route Table

resource "aws_route_table_association" "Public_subnet_1-route_table_association" {
  subnet_id      = aws_subnet.Public_subnet_1.id
  route_table_id = aws_route_table.Public_route_table.id
}

 #Associate Public Subnet 2 to Public Route Table
 resource "aws_route_table_association" "Public_subnet_2-route_table_association" {
  subnet_id      = aws_subnet.Public_subnet_2.id
  route_table_id = aws_route_table.Public_route_table.id
}

# Create Private Subnet
resource "aws_subnet" "Private_Subnet_1" {
  vpc_id     = aws_vpc.my-VPC.id
  cidr_block = "${var.Private_subnet_1-cidr}"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private_Subnet_1"
  }
}

resource "aws_subnet" "Private_Subnet_2" {
  vpc_id     = aws_vpc.my-VPC.id
  cidr_block = "${var.Private_subnet_2-cidr}"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private_Subnet_2"
  }
}





