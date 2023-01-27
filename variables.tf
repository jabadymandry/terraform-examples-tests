variable "vpc_cidr_block" {
  type        = string
  description = "Cidr for VPC to create"
  default     = "10.10.0.0/16"
}

variable "subnet_1" {
  type        = string
  description = "Subnet 1 to create"
}

variable "ami" {
  type        = string
  description = "AMI for instance to use"
}

variable "key_ssh" {
  type        = string
  description = "SSH key name to use for remote connexion"
}

variable "instance_name" {
  type        = string
  description = "Name of instance to create"
  default     = "test-instance"
}

variable "project_name" {
  type        = string
  description = "Name of projet to create used in Projet tag"
}

variable "disk_size" {
  type        = number
  description = "Size of block disk to create on instance"
  default     = 10
}

variable "sg_egress" {
  type = map(object({
    description = string,
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_block  = list(string)
  }))
}

variable "sg_ingress" {
  type = map(object({
    description = string,
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_block  = list(string)
  }))
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "iam_profile" {
  type    = string
  default = "InstancesRole"
}