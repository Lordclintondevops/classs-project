variable "igw" {
    default = "aws_ec2_transit_gateway.tgw"
  
}

variable "tgw_vpc_id" {
    default = "aws_vpc.liengevpc"
  
}

variable "subnet_id_pub" {
    default = "aws_subnet.liengesubpub"
  
}

variable "subnet_id_priv" {
    default = "aws_subnet.liengesubpriv"
  
}
