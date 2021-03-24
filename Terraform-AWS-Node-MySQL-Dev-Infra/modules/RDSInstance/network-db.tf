#Create VPC
resource "aws_vpc" "vpc-db" {
  cidr_block = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.environment_DB_tag
  }
}


#Create Subnet
resource "aws_subnet" "subnet_db" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.vpc-db.id
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = "10.20.${0+count.index}.0/24"
  tags= {
    Name = var.environment_DB_tag
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "igw_db" {
  vpc_id = aws_vpc.vpc-db.id
  tags= {
    Environment = var.environment_DB_tag
  }
}

#Create routing table
resource "aws_route_table" "rtb_db_public" {
  vpc_id = aws_vpc.vpc-db.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw_db.id
  }
tags ={
    Environment = var.environment_DB_tag
  }
}


#Create AWS security group
resource "aws_security_group" "sg_db" {
  name = "sg_db"
  vpc_id = aws_vpc.vpc-db.id
  ingress {
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags= {
    Name = var.environment_DB_tag
  }

}


   