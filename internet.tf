resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name"   = "${var.project_name}-IGW"
    "Projet" = var.project_name
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw.id
  }

  tags = {
    "Name" = "Test-rt"
  }
}

resource "aws_route_table_association" "rt-association" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.subnet_1.id
}

resource "aws_eip" "eip-igw" {
  depends_on = [
    aws_internet_gateway.Igw
  ]
  vpc      = true
  instance = aws_instance.Instance1.id
}