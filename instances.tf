resource "aws_security_group" "Sg1" {
  description = "SG-${var.project_name}"
  vpc_id      = aws_vpc.vpc.id
  name        = "test-${var.project_name}"
  tags = {
    "Projet" = var.project_name
  }
}

resource "aws_security_group_rule" "Sg-in-ssh" {
  type              = "ingress"
  description       = "Allow SSH from outside"
  from_port         = "22"
  to_port           = "22"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Sg1.id
}

resource "aws_security_group_rule" "Sg-in-icmp" {
  type              = "ingress"
  description       = "Allow PING from outside"
  from_port         = "-1"
  to_port           = "-1"
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Sg1.id
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