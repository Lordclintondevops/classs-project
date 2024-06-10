# Creating Peering Connections VPC1 to VPC2

resource "aws_vpc_peering_connection" "lienge_peering" {
  vpc_id      = aws_vpc.liengevpc[0].id // Requester
  peer_vpc_id = aws_vpc.liengevpc[1].id // Accepter

  tags = {
    Name = "lienge_peering"
  }

}

# Creating Peering Connections VPC1 to VPC3

resource "aws_vpc_peering_connection" "lienge_peering1" {
  vpc_id      = aws_vpc.liengevpc[0].id // Requester
  peer_vpc_id = aws_vpc.liengevpc[2].id // Accepter

  tags = {
    Name = "lienge_peering1"
  }

}
