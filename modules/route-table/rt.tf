resource "aws_route_table" "liengert_public" {
  count  = length(var.azsubnet_pub)
  vpc_id = aws_vpc.liengevpc[0].id

  tags = {
    Name = "liengert"
  }
}

resource "aws_route" "liengert_default1" {
  route_table_id         = aws_route_table.liengert_public[count.index % length(var.azsubnet_pub)].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lienge_igw.id

  count = length(var.azsubnet_pub)
}

resource "aws_route" "liengert_default0" {
    route_table_id = aws_route_table.liengert_public[0].id
    destination_cidr_block = var.cidrvpc[1]
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
    
}

resource "aws_route" "liengert_default2" {
    route_table_id = aws_route_table.liengert_public[0].id
    destination_cidr_block = var.cidrvpc[2]
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}


# Creating our Route Table with No Internet Connection

resource "aws_route_table" "liengert_private" {
  count  = length(var.azsubnet_priv0)
  vpc_id = aws_vpc.liengevpc[1].id


  tags = {
    Name = "liengert1"
  }

}

# resource "aws_route" "s3_route_vpc" {
#   count                   = length(aws_subnet.liengesubpriv)
#   route_table_id          = aws_route_table.liengert_private[count.index].id
#   destination_cidr_block  = var.cidrvpc[1]  
#   vpc_endpoint_id         = aws_vpc_endpoint.s3_endpoint[count.index].id
#   depends_on = [aws_vpc_endpoint.s3_endpoint]
# }

# resource "aws_route_table" "liengert_private1" {
#   count  = length(var.azsubnet_priv1)
#   vpc_id = aws_vpc.liengevpc[2].id


#   tags = {
#     Name = "liengert2"
#   }
# }

# resource "aws_route" "s3_route_vpc2" {
#   count                   = length(aws_subnet.liengesubpriv)
#   route_table_id          = aws_route_table.liengert_private1[count.index].id
#   destination_cidr_block  = var.cidrvpc[2]  # or specific CIDR block for S3 if desired
#   vpc_endpoint_id         = aws_vpc_endpoint.s3_endpoint[count.index].id
#   depends_on = [aws_vpc_endpoint.s3_endpoint]
# }

