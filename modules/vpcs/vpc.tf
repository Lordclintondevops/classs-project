# Creating our VPC's

resource "aws_vpc" "liengevpc" {
  count            = length(var.cidrvpc)
  cidr_block       = var.cidrvpc[count.index]
  instance_tenancy = var.tenancy


  tags = {
    Name = "${var.vpctags[count.index]}"
  }

}