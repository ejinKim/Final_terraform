# public route table

resource "aws_route_table" "rt_pub" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Final-rt-pub"
  }
}

# public route table ass

resource "aws_route_table_association" "rt_pub_ass" {
  count = length(var.zone)
  subnet_id      = aws_subnet.pub_subnet[count.index].id
  route_table_id = aws_route_table.rt_pub.id
}

resource "aws_route_table_association" "rt_mgmt_ass" {
  count = 1
  subnet_id      = aws_subnet.mgmt_subnet[count.index].id
  route_table_id = aws_route_table.rt_pub.id
}




# private route table

resource "aws_route_table" "rt_pri" {

  count = length(var.zone)
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_nat_gateway.natgw[count.index].id
  }

  tags = {
    Name = "Final-rt-pri-${var.zone[count.index]}"
  }
}

# private route table ass

resource "aws_route_table_association" "rt_web_ass" {
  count          =  length(var.zone)  
  subnet_id      = aws_subnet.web_subnet[count.index].id
  route_table_id = aws_route_table.rt_pri[count.index].id
}

resource "aws_route_table_association" "rt_was_ass" {
  count          =  length(var.zone)  
  subnet_id      = aws_subnet.was_subnet[count.index].id
  route_table_id = aws_route_table.rt_pri[count.index].id
}

