# Creating our Route Table

resource "aws_route_table" "liengert" {
  count  = length(var.azsubnet_pub)
  vpc_id = aws_vpc.liengevpc[count.index].id

  dynamic "route" {
    for_each = var.azsubnet_pub
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.liengeigw.id
    }

  }

  tags = {
    Name = "liengert"
  }
}

# Creating our Route Table No Connection

resource "aws_route_table" "liengert1" {
  count  = length(var.azsubnet_priv)
  vpc_id = aws_vpc.liengevpc[count.index % length(aws_vpc.liengevpc)].id


  tags = {
    Name = "liengert1"
  }
}

# Associating Subnets to the route table

resource "aws_route_table_association" "liengerta" {
  count          = length(var.azsubnet_pub)
  route_table_id = aws_route_table.liengert[count.index].id
  subnet_id      = aws_subnet.liengesubpub[count.index].id

}

resource "aws_route_table_association" "liengerta1" {
  count          = length(var.azsubnet_priv)
  route_table_id = aws_route_table.liengert1[count.index].id
  subnet_id      = aws_subnet.liengesubpriv[count.index].id

}

# Creating a Route table for the VPC1 to VPC2 Peering

resource "aws_route_table" "lienge_peering" {
  vpc_id = aws_vpc.liengevpc[0].id

  route {
    cidr_block                = aws_vpc.liengevpc[1].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.lienge_peering.id
  }

  tags = {
    Name = "requester"
  }
}

# Creating a Route table for the VPC Peering

resource "aws_route_table" "lienge_peering01" {
  vpc_id = aws_vpc.liengevpc[1].id

  route {
    cidr_block                = aws_vpc.liengevpc[0].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.lienge_peering.id
  }

  tags = {
    Name = "accepter"
  }
}

# Creating a Route table for the VPC Peering

resource "aws_route_table" "lienge_peering0" {
  vpc_id = aws_vpc.liengevpc[0].id

  route {
    cidr_block                = aws_vpc.liengevpc[2].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.lienge_peering.id
  }

  tags = {
    Name = "requester1"
  }
}

# Creating a Route table for the VPC1 to VPC3 Peering

resource "aws_route_table" "lienge_peering1" {
  vpc_id = aws_vpc.liengevpc[2].id

  route {
    cidr_block                = aws_vpc.liengevpc[0].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.lienge_peering1.id
  }

  tags = {
    Name = "accepter1"
  }
}
