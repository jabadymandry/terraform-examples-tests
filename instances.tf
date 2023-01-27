resource "aws_security_group" "Sg1" {
  description = "SG-${var.project_name}"
  vpc_id      = aws_vpc.vpc.id

  dynamic "egress" {
    for_each = var.sg_egress
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_block
    }
  }

  dynamic "ingress" {
    for_each = var.sg_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_block
    }
  }

  tags = {
    "Projet" = var.project_name
  }
}

resource "aws_key_pair" "Ssh_Key" {
  key_name   = "${var.instance_name}-${var.key_ssh}"
  public_key = file("${var.key_ssh}.pub")

  tags = {
    "Projet" = var.project_name
  }
}


resource "aws_instance" "Instance1" {
  key_name        = aws_key_pair.Ssh_Key.key_name
  ami             = var.ami
  subnet_id       = aws_subnet.subnet_1.id
  security_groups = [aws_security_group.Sg1.id]
  instance_type   = var.instance_type
  #associate_public_ip_address = true
  iam_instance_profile = var.iam_profile

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp3"
    volume_size           = var.disk_size
    encrypted             = true
  }

  tags = {
    "Name"   = "${var.instance_name}-${var.project_name}"
    "Projet" = var.project_name
  }
}