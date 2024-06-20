# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = aws_vpc.liengevpc[*].id

# }

# output "subnet_id" {
#   description = "The IDs of the Subnetts"
#   value       = aws_subnet.liengesubpub[*].id

# }

# output "subnet_id1" {
#   description = "The IDs for Private"
#   value       = aws_subnet.liengesubpriv[*].id

# }

# output "aws_security_group_id" {
#   description = "The ID of the security group"
#   value       = aws_security_group.sg[*]

# }

# output "s3_endpoint_id" {
#     value = aws_vpc_endpoint.s3_endpoint.id

# }

# Components of the EC2

output "ec2_subnets" {
    value = module.ec2-instances.subnets
  
}

output "ec2_sg" {
    value = module.ec2-instances.sg
  
}

output "ec2_sg1" {
    value = module.ec2-instances.sg1
  
}

output "ec2_subnets1" {
    value = module.ec2-instances.subnet1s
  
}

output "igw_aws_vpc" {
    value = module.igw.aws_vpc
  
}

output "route_table_vpc" {
    value = module.route-table.vpc
  
}

# Components of the S_3 Endpoints

output "s3_endpoint_vpc" {
    value = module.s3-endpoints.vpc10
  
}

output "s3_endpoint_vpc1s" {
    value = module.s3-endpoints.vpc1s
  
}

output "security_group_vpc101" {
    value = module.security.vpc101
  
}

output "subnet_vpcs" {
    value = module.subnet.subnet_vpc
  
}

# Components of the Transit Gateway Attachments

output "transit_at_tgw" {
    value = module.transit-attachment.transit_tgw
  
}

output "transit_at_tgw1" {
    value = module.transit-attachment.transit_attachment_tgw
  
}

output "transit_at_subpub" {
    value = module.transit-attachment.transit_attachment_sbpub
  
}

output "transit_at_subpriv" {
    value = module.transit-attachment.transit_attachment_sbpriv
  
}

# Components of the VPC FLow Logs

output "vpc_flow_vpc_id" {
    value = module.vpc-flow-logs.vpc_flow_logs_vpc
  
}