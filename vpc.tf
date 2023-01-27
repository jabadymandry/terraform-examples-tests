resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name"   = "Test-vpc",
    "Projet" = var.project_name
  }
}