output "Instance-Id" {
  value = aws_instance.Instance1.id
}

output "Instance-IpPublic" {
  value = aws_eip.eip-igw.public_ip
}

output "Instance-Subnet" {
  value = aws_instance.Instance1.associate_public_ip_address
}