resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "Public Subnet"
  }
}