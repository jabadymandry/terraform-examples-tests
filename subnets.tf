resource "aws_subnet" "subnet_1" {
  cidr_block = var.subnet_1
  vpc_id     = aws_vpc.vpc.id

  tags = {
    "Name"   = "Test-subnet-1",
    "Projet" = var.project_name
  }
}