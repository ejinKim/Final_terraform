resource "aws_eip" "Final_mgmt_eip"{
  count                = 1
  instance             = aws_instance.mgmt_jenkins[0].id
  vpc                  = true
  tags = {
    Name = "Final-mgmt-eip"
  }
}


# instance

#resource "aws_instance" "mgmt" {
#  count                  = 1
#  ami                    = var.ami
#  instance_type          = "t2.micro"
#  key_name               = var.key_pair
#  vpc_security_group_ids = [aws_security_group.mgmt_sg.id]
#  availability_zone      = "${var.region}${var.zone[count.index]}"
#  private_ip             = null
#  subnet_id              = aws_subnet.pub_subnet[count.index].id
#  tags = {
#    Name                 = "Final-mgmt"
#    }
#}

resource "aws_instance" "mgmt_jenkins" {
  count                  = 1
  ami                    = var.ami
  instance_type          = "t2.large"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.mgmt_sg.id]
  availability_zone      = "ap-northeast-2a"
  subnet_id              = aws_subnet.mgmt_subnet[0].id
  private_ip             = null
  tags = {
    Name                 = "Final-mgmt-jenkins"
    }
}

resource "aws_instance" "mgmt_ansible" {
  count                  = 1
  ami                    = var.ami
  instance_type          = "t2.large"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.mgmt_sg.id]
  availability_zone      = "ap-northeast-2a"
  subnet_id              = aws_subnet.mgmt_subnet[0].id
  associate_public_ip_address = true
  private_ip             = null
  tags = {
    Name                 = "Final-mgmt-ansible"
    }
}

resource "aws_instance" "mgmt" {
  count                  = length(var.instance_name)
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.mgmt_sg.id]
  availability_zone      = "ap-northeast-2a"
  subnet_id              = aws_subnet.mgmt_subnet[0].id
  associate_public_ip_address = true
  private_ip             = null
  tags = {
    Name                 = "Final-mgmt-${var.instance_name[count.index]}"
    }
}

resource "aws_instance" "web" {
  count                  = length(var.zone)
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  availability_zone      = "${var.region}${var.zone[count.index]}"
  private_ip             = null
  subnet_id              = aws_subnet.web_subnet[count.index].id
  tags = {
    Name                 = "Final-web-${var.zone[count.index]}"
    Type                 = "apache-${var.zone[count.index]}"
    }
}


resource "aws_instance" "was" {
  count                  = length(var.zone)
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.was_sg.id]
  availability_zone      = "${var.region}${var.zone[count.index]}"
  private_ip             = null
  subnet_id              = aws_subnet.was_subnet[count.index].id
  tags = {
    Name                 = "Final-was-${var.zone[count.index]}"
    }
}