output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.liengevpc[*].id

}

output "subnet_id" {
  description = "The IDs of the Subnetts"
  value       = aws_subnet.liengesubpub[*].id

}

output "subnet_id1" {
  description = "The IDs for Private"
  value       = aws_subnet.liengesubpriv[*].id

}

output "aws_security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.sg[*]

}