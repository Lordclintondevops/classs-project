# Creating an internet gateway

resource "aws_internet_gateway" "lienge_igw" {
  vpc_id = aws_vpc.liengevpc[0].id
}
