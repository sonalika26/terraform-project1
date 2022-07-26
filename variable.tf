variable "vpc-cidr" {
    default = "10.10.0.0/16"
    description = "VPC CIDR Block"
    type =  string
  
}

variable "Public_subnet_1-cidr" {
    default = "10.10.1.0/24"
    description = "Public subnet 1 CIDR Block"
    type =  string
  
}

variable "Public_subnet_2-cidr" {
    default = "10.10.2.0/24"
    description = "Public subnet 2 CIDR Block"
    type =  string
  
}

variable "Private_subnet_1-cidr" {
    default = "10.10.3.0/24"
    description = "Private subnet 1 CIDR Block"
    type =  string
  
}

variable "Private_subnet_2-cidr" {
    default = "10.10.4.0/24"
    description = "Private subnet 2 CIDR Block"
    type =  string
  
}

variable "ssh-location" {
    default = "10.10.2.0/24"
    description = "IP Address That can SSH into the EC2 Instance"
    type =  string
  
}


variable "database-instance_class" {
    default = "t2.micro"
    description = "Database instance type"
    type =  string
  
}

variable "database-instance-identifier" {
    default = "database-1"
    description = "Database instance identifier"
    type =  string
  
}

variable "username" {
    default =  "dbadmin"
  
}

variable "password" {
    default =  "Sonalika_26"
  
}
