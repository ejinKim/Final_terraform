# vpc

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "Final-VPC"
   }
}



# subnet

resource "aws_subnet" "mgmt_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    count = length(var.mgmt_subnet)
    cidr_block = var.mgmt_subnet[count.index]
    availability_zone = "${var.region}${var.zone[count.index]}"
    tags = {
      Name = "Final-mgmt-subnet-${var.zone[count.index]}"
    }
}

resource "aws_subnet" "pub_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    count = length(var.pub_subnet)
    cidr_block = var.pub_subnet[count.index]
    availability_zone = "${var.region}${var.zone[count.index]}"
    tags = {
      Name = "Final-pub-subnet-${var.zone[count.index]}"
    }
}

resource "aws_subnet" "web_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    count = length(var.web_subnet)
    cidr_block = var.web_subnet[count.index]
    availability_zone = "${var.region}${var.zone[count.index]}"
    tags = {
      Name = "Final-web-subnet-${var.zone[count.index]}"
    }
}

resource "aws_subnet" "was_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    count = length(var.was_subnet)
    cidr_block = var.was_subnet[count.index]
    availability_zone = "${var.region}${var.zone[count.index]}"
    tags = {
      Name = "Final-was-subnet-${var.zone[count.index]}"
    }
}

resource "aws_subnet" "db_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    count = length(var.db_subnet)
    cidr_block = var.db_subnet[count.index]
    availability_zone = "${var.region}${var.zone[count.index]}"
    tags = {
      Name = "Final-db-subnet-${var.zone[count.index]}"
    }
}
