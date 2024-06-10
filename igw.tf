# Creating an internet gateway

resource "aws_internet_gateway" "liengeigw" {
  vpc_id = var.vpctags[0]

}