# Creating an internet gateway

resource "aws_internet_gateway" "liengeigw" {
  vpc_id = aws_vpc.liengevpc[0].id

}