resource "aws_security_group" "mgmt_sg" {
  name        = "Final-mgmt-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${var.cidr_block}"]
    }

  ingress {
      description      = "Allow 8080"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = ["${var.cidr_block}"]
    }

  ingress {
      description      = "rds from VPC"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["${var.cidr_block}"]
    }
  egress {
      description      = "all allow"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["${var.cidr_block}"]
    }

  tags = {
    Name = "Final-mgmt-sg"
  }
}





resource "aws_security_group" "web_sg" {
  name        = "Final-web-sg"
  description = "Allow ssh, http inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress = [
    {
      description      = "SSH from mgmt"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      security_groups = [aws_security_group.mgmt_sg.id]
      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids   =   null
      self              =   null 
    },
    {
      description      = "HTTP from alb"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      security_groups = [aws_security_group.alb_sg.id]
      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids   =   null
      self              =   null
    }
  ]

  egress = [
    {
      description      = "all allow"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["${var.cidr_block}"]
      ipv6_cidr_blocks = ["${var.ipv6_cidr_blocks}"]
      security_groups   =   null
      prefix_list_ids   =   null
      self              =   null 
    }
  ]

  tags = {
    Name = "Final-web-sg"
  }
}





resource "aws_security_group" "was_sg" {
  name        = "Final-was-sg"
  description = "Allow ssh, 8080 inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress = [
    {
      description      = "SSH from mgmt"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      security_groups = [aws_security_group.mgmt_sg.id]
      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids   =   null
      self              =   null
    },
    {
      description      = "Allow 8080"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      security_groups = [aws_security_group.web_sg.id]
      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids   =   null
      self              =   null
    }
  ]

  egress = [
    {
      description      = "all allow"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["${var.cidr_block}"]
      ipv6_cidr_blocks = ["${var.ipv6_cidr_blocks}"]
      security_groups   =   null
      prefix_list_ids   =   null
      self              =   null 
    }
  ]

  tags = {
    Name = "Final-was-sg"
  }
}





resource "aws_security_group" "db_sg" {
  name        = "Final-db-sg"
  description = "Allow rds inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id


  ingress {
    description     = "Allow traffic from was server"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.was_sg.id]
    cidr_blocks      = null
    ipv6_cidr_blocks = null
    prefix_list_ids   =   null
    self              =   null 
  }
  egress {
    description      = "all allow"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["${var.cidr_block}"] 
    ipv6_cidr_blocks = ["${var.ipv6_cidr_blocks}"]
    security_groups   =   null
    prefix_list_ids   =   null
    self              =   null 
  }
  
  tags = {
    Name = "Final-db-sg"
  }
}





resource "aws_security_group" "alb_sg" {
  name        = "Final-alb-sg"
  description = "Allow alb inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id


  ingress {
    description      = "All allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["${var.cidr_block}"]
    ipv6_cidr_blocks = ["${var.ipv6_cidr_blocks}"]
    security_groups   =   null
    prefix_list_ids   =   null
    self              =   null
  }
  egress {
    description      = "all allow"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["${var.cidr_block}"] 
    ipv6_cidr_blocks = ["${var.ipv6_cidr_blocks}"]
    security_groups   =   null
    prefix_list_ids   =   null
    self              =   null 
  }
  
  tags = {
    Name = "Final-alb-sg"
  }
}

