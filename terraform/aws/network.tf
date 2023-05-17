# ----------------- VPC -----------------

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}



# ----------------- Internet Gateway -----------------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}



# ----------------- Subnets -----------------

resource "aws_subnet" "private-us-east-2a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-2a"

  tags = {
    "Name"                                      = "private-us-east-2a"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.project}" = "owned"
  }
}

resource "aws_subnet" "private-us-east-2b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-east-2b"

  tags = {
    "Name"                                      = "private-us-east-2b"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.project}" = "owned"
  }
}

resource "aws_subnet" "public-us-east-2a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-us-east-2a"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.project}" = "owned"
  }
}

resource "aws_subnet" "public-us-east-2b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-us-east-2b"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.project}" = "owned"
  }
}



# ----------------- NAT Gateway -----------------

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-east-2a.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}



# ----------------- Routes -----------------

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "private-us-east-2a" {
  subnet_id      = aws_subnet.private-us-east-2a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-us-east-2b" {
  subnet_id      = aws_subnet.private-us-east-2b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public-us-east-2a" {
  subnet_id      = aws_subnet.public-us-east-2a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-2b" {
  subnet_id      = aws_subnet.public-us-east-2b.id
  route_table_id = aws_route_table.public.id
}
