#Allocate Elastic ip address (EIP 1)
resource "aws_eip" "eip-for-nat-gateway-1" {
  vpc      = true

  tags =   {

    Name = "EIP 1"
  }
}

#Allocate Elastic ip address (EIP 2)
resource "aws_eip" "eip-for-nat-gateway-2" {
  vpc      = true

  tags = {

    Name ="EIP 2"
  }
}

# Create Nat Gateway 1 in Public Subnet 1
resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id = aws_eip.eip-for-nat-gateway-1.id
  subnet_id     = aws_subnet.Public_subnet_1.id

  tags = {
    Name = "NAT Gateway Public Subnet 1"
  }
}

  # Create Nat Gateway 2 in Public Subnet 2
resource "aws_nat_gateway" "nat-gateway-2" {
  allocation_id = aws_eip.eip-for-nat-gateway-2.id
  subnet_id     = aws_subnet.Public_subnet_2.id

  tags = {
    Name = "NAT Gateway Public Subnet 2"
  }
}

# Create Private Route Table 1 and Add Route Trough Nat Gteway 1

resource "aws_route_table" "Private-route-table-1" {
  vpc_id = aws_vpc.my-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-1.id
  }

  
  tags = {
    Name = " Private Route Table 1"
  }
}

# Associate Private Subnet 1 with Private Route Table 1

resource "aws_route_table_association" "Private_subnet_1-route_table_association" {
  subnet_id      = aws_subnet.Private_Subnet_1.id
  route_table_id = aws_route_table.Private-route-table-1.id
}


# Create Private Route Table 2 and Add Route Trough Nat Gteway 2

resource "aws_route_table" "Private-route-table-2" {
  vpc_id = aws_vpc.my-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-2.id
  }

  
  tags = {
    Name = " Private Route Table 2"
  }
}

# Associate Private Subnet 2 with Private Route Table 2

resource "aws_route_table_association" "Private_subnet_2-route_table_association" {
  subnet_id      = aws_subnet.Private_Subnet_2.id
  route_table_id = aws_route_table.Private-route-table-2.id
}
