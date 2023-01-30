subnet_1      = "10.10.0.0/24"
ami           = "ami-00874d747dde814fa"
project_name  = "Test"
key_ssh       = "ssh-test"
instance_name = "instance"
instance_type = "t2.micro"

sg_egress = {
  "1" = {
    cidr_block  = ["0.0.0.0/0"]
    description = "Allow all TCP from internal to external"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

sg_ingress = {
  "SSH" = {
    cidr_block  = ["0.0.0.0/0"]
    description = "Allow SSH incomming from external"
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
  },
  "PING_REPLY" = {
    cidr_block  = ["0.0.0.0/0"]
    description = "Allow ICMP incomming from external"
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
  }
}