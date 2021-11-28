# region & vpc
variable "region" {
  description = "aws seoul region"
  default     = "ap-northeast-2"
}

variable "vpc_cidr" {
  description = "vpc cidr"
  default     = "10.0.0.0/16"
}

variable "vpc" {
  description = "vpc"
  default     = "aws_vpc.my_vpc"
}

variable "vpc_id" {
  description = "vpc ID"
  default     = "aws_vpc.my_vpc.id"
}


# subnet

variable "zone" {
  description = "aws AZ"
  default     = ["a","c"]
}

variable "mgmt_subnet" {
  description = "Final mgmt subnet for mgmt"
  default     = ["10.0.0.0/27"]
}

variable "pub_subnet" {
  description = "Final pub subnet for alb, nat"
  default     = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "web_subnet" {
  description = "Final web subnet for web server"
  default     = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "was_subnet" {
  description = "Final was subnet for was server"
  default     = ["10.0.5.0/24","10.0.6.0/24"]
}

variable "db_subnet" {
  description = "Final db subnet for RDS"
  default     = ["10.0.7.0/27","10.0.7.32/27"]
}

variable "instance_name"{
  description = "mgmt instance name"
  default = ["bastion","RDS"]
}




# Route Table

variable "cidr_block" {
  description = "All IP"
  default     = "0.0.0.0/0"
}

variable "ipv6_cidr_blocks" {
  description = "All IPv6"
  default     = "::/0"
}




# instance

variable "ami" {
  description = "aws ami"
  default     = "ami-0252a84eb1d66c2a0"
}


variable "key_pair" {
  description = "aws key_pair"
  default     = "final-key"
}




# S3 

variable "alb_account_id" {
  description = "alb account id"
  default     = "600734575887"
}