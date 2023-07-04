resource "aws_security_group" "default" {
  name_prefix = var.project
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "databases" {
  name_prefix = var.project
  vpc_id      = aws_vpc.main.id

  # Allow the EC2 located in public-subnet-c to connect only through port 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public-subnet-c.cidr_block]
  }

  # Allow the EKS nodes located in private-subnet-a and private-subnet-b to connect.
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_subnet.public-subnet-c.cidr_block, aws_subnet.private-subnet-a.cidr_block, aws_subnet.private-subnet-b.cidr_block]
  }
}