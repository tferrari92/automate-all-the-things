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

# Public & private subnets in Availability Zone A
resource "aws_subnet" "public-subnet-a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/19"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                         = "public-${var.region}-a"
    "kubernetes.io/role/elb"                       = "1"
    "kubernetes.io/cluster/${var.project}-cluster" = "owned"
  }
}

resource "aws_subnet" "private-subnet-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "${var.region}a"

  tags = {
    "Name"                                         = "private-${var.region}-a"
    "kubernetes.io/role/internal-elb"              = "1"
    "kubernetes.io/cluster/${var.project}-cluster" = "owned"
  }
}

# Public & private subnets in Availability Zone B
resource "aws_subnet" "public-subnet-b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                         = "public-${var.region}-b"
    "kubernetes.io/role/elb"                       = "1"
    "kubernetes.io/cluster/${var.project}-cluster" = "owned"
  }
}

resource "aws_subnet" "private-subnet-b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.96.0/19"
  availability_zone = "${var.region}b"

  tags = {
    "Name"                                         = "private-${var.region}-b"
    "kubernetes.io/role/internal-elb"              = "1"
    "kubernetes.io/cluster/${var.project}-cluster" = "owned"
  }
}

# Public & private subnets in Availability Zone C
resource "aws_subnet" "public-subnet-c" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}c"
  cidr_block              = "10.0.128.0/19"

  map_public_ip_on_launch = true
  tags = {
    "Name"                                         = "public-${var.region}-c"
    "Purpose"                                      = "EC2"
  }
}

resource "aws_subnet" "private-subnet-c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.160.0/19"
  availability_zone = "${var.region}c"

  tags = {
    "Name"                                         = "private-${var.region}-c"
    "Purpose"                                      = "Databases"
  }
}



# ----------------- NAT Gateway -----------------

# For AZ A Public Subnet
resource "aws_eip" "eip-a" { 
  vpc = true

  tags = {
    Name = "eip-a" 
  }
}

resource "aws_nat_gateway" "ngw-a" { 
  allocation_id = aws_eip.eip-a.id 
  subnet_id     = aws_subnet.public-subnet-a.id

  tags = {
    Name = "ngw-a"
  }

  depends_on = [aws_internet_gateway.igw]
}

# For AZ B Public Subnet
resource "aws_eip" "eip-b" {
  vpc = true

  tags = {
    Name = "eip-b"
  }
}

resource "aws_nat_gateway" "ngw-b" {
  allocation_id = aws_eip.eip-b.id
  subnet_id     = aws_subnet.public-subnet-b.id

  tags = {
    Name = "ngw-b"
  }

  depends_on = [aws_internet_gateway.igw]
}

# # For AZ C Public Subnet
resource "aws_eip" "eip-c" {
  vpc = true

  tags = {
    Name = "eip-c"
  }
}

resource "aws_nat_gateway" "ngw-c" {
  allocation_id = aws_eip.eip-c.id
  subnet_id     = aws_subnet.public-subnet-c.id

  tags = {
    Name = "ngw-c"
  }

  depends_on = [aws_internet_gateway.igw]
}

# ----------------- Routes -----------------

# For all public subnets
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

# For private subnet a
resource "aws_route_table" "private-a" { 
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-a.id 
  }

  tags = {
    Name = "private-subnet-a"
  }
}

# For private subnet b
resource "aws_route_table" "private-b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-b.id
  }

  tags = {
    Name = "private-subnet-b"
  }
}

# # For private subnet c
resource "aws_route_table" "private-c" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-c.id
  }

  tags = {
    Name = "private-subnet-c"
  }
}

# Assosiation for AZ A
resource "aws_route_table_association" "public-subnet-a" {
  subnet_id      = aws_subnet.public-subnet-a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-subnet-a" {
  subnet_id      = aws_subnet.private-subnet-a.id
  route_table_id = aws_route_table.private-a.id 
}

# Assosiation for AZ B
resource "aws_route_table_association" "public-subnet-b" {
  subnet_id      = aws_subnet.public-subnet-b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-subnet-b" {
  subnet_id      = aws_subnet.private-subnet-b.id
  route_table_id = aws_route_table.private-b.id 
}

# Assosiation for AZ C
resource "aws_route_table_association" "public-subnet-c" {
  subnet_id      = aws_subnet.public-subnet-c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-subnet-c" {
  subnet_id      = aws_subnet.private-subnet-c.id
  route_table_id = aws_route_table.private-c.id
}