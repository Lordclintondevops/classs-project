# Attach VPCs to Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment_vpc1" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.liengevpc[0].id  # VPC1

  subnet_ids = [
    aws_subnet.liengesubpub[0].id,               # Public subnet 1 of VPC1
    aws_subnet.liengesubpub[1].id                # Public subnet 2 of VPC1
  ]

  tags = {
    Name = "TGW-Attachment-VPC1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment_vpc2" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.liengevpc[1].id  # VPC2

  subnet_ids = [
    aws_subnet.liengesubpriv[0].id,              # Private subnet 1 of VPC2
    aws_subnet.liengesubpriv[1].id               # Private subnet 2 of VPC2
  ]

  tags = {
    Name = "TGW-Attachment-VPC2"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment_vpc3" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.liengevpc[2].id  # VPC3

  subnet_ids = [
    aws_subnet.liengesubpriv1[0].id,             # Private subnet 1 of VPC3
    aws_subnet.liengesubpriv1[1].id              # Private subnet 2 of VPC3
  ]

  tags = {
    Name = "TGW-Attachment-VPC3"
  }
}

