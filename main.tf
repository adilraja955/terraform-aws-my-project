provider "aws" {
  region = var.region
}

resource "aws_vpc" "development_vpc" {
  cidr_block = var.cidr_block[0]
  tags = {
    Name = "development"
  }
}

resource "aws_subnet" "development_subnet_pub_1" {
  vpc_id            = aws_vpc.development_vpc.id
  cidr_block        = var.cidr_block[1]
  availability_zone = var.zone[0]
  tags = {
    Name = "development-public-1"
  }
}

resource "aws_subnet" "development_subnet_pub_2" {
  vpc_id            = aws_vpc.development_vpc.id
  cidr_block        = var.cidr_block[2]
  availability_zone = var.zone[1]
  tags = {
    Name = "development-public-2"
  }
}

resource "aws_subnet" "development_subnet_priv_1" {
  vpc_id            = aws_vpc.development_vpc.id
  cidr_block        = var.cidr_block[3]
  availability_zone = var.zone[0]
  tags = {
    Name = "development-private-1"
  }
}

resource "aws_subnet" "development_subnet_priv_2" {
  vpc_id            = aws_vpc.development_vpc.id
  cidr_block        = var.cidr_block[4]
  availability_zone = var.zone[1]
  tags = {
    Name = "development-private-2"
  }
}
resource "aws_internet_gateway" "development_igw" {
  vpc_id = aws_vpc.development_vpc.id
  tags = {
    Name = "development-igw"
  }
}
resource "aws_route_table" "development_public_rt" {
  vpc_id = aws_vpc.development_vpc.id
  route {
    cidr_block = var.route
    gateway_id = aws_internet_gateway.development_igw.id
  }
  tags = {
    Name = "development-public-rt"
  }
}
resource "aws_route_table" "development_private_rt" {
  vpc_id = aws_vpc.development_vpc.id
  tags = {
    Name = "development-private-rt"
  }
}
resource "aws_route_table_association" "pub_1_association" {
  subnet_id      = aws_subnet.development_subnet_pub_1.id
  route_table_id = aws_route_table.development_public_rt.id
}
resource "aws_route_table_association" "pub_2_association" {
  subnet_id      = aws_subnet.development_subnet_pub_2.id
  route_table_id = aws_route_table.development_public_rt.id
}
resource "aws_route_table_association" "priv_1_association" {
  subnet_id      = aws_subnet.development_subnet_priv_1.id
  route_table_id = aws_route_table.development_private_rt.id
}
resource "aws_route_table_association" "priv_2_association" {
  subnet_id      = aws_subnet.development_subnet_priv_2.id
  route_table_id = aws_route_table.development_private_rt.id
}


