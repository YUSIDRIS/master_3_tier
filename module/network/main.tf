resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-IGW"
  }
}
# this the availability zones
data "aws_availability_zones" "AZ" {}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr[0].cidr_block
  availability_zone = data.aws_availability_zones.AZ.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet_cidr[0].name}-SUBNET"
  }
}



resource "aws_subnet" "public_subnet_az2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr[1].cidr_block
  availability_zone = data.aws_availability_zones.AZ.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet_cidr[1].name}-SUBNET"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "${var.project_name}-PUBLIC_ROUTE_TABLE"
  }
}

resource "aws_route_table_association" "associate1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "associate2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_app_subnet_cidr[0].cidr_block
  availability_zone = data.aws_availability_zones.AZ.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.private_app_subnet_cidr[0].name}-SUBNET"
  }
}

resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_app_subnet_cidr[1].cidr_block
  availability_zone = data.aws_availability_zones.AZ.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.private_app_subnet_cidr[1].name}-SUBNET"
  }
}

resource "aws_subnet" "data_base_subnet_az1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.data_base_subnet_cidr[0].cidr_block
  availability_zone = data.aws_availability_zones.AZ.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.data_base_subnet_cidr[0].name}-SUBNET"
  }
}

resource "aws_subnet" "data_base_subnet_az2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.data_base_subnet_cidr[1].cidr_block
  availability_zone = data.aws_availability_zones.AZ.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.data_base_subnet_cidr[1].name}-SUBNET"
  }
}


