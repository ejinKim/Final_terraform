# internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags   = {
    Name = "Final-igw"
  }
}






# nat gateway

resource "aws_eip" "nat_eip" {
  count    = length(var.zone)
  vpc      = true
  tags = {
    Name = "Final-nat-eip-${var.zone[count.index]}"
  }
}

resource "aws_nat_gateway" "natgw" {
  count = length(var.zone)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.pub_subnet[count.index].id

  tags = {
    Name = "Final-natgw-${var.zone[count.index]}"
  }
}