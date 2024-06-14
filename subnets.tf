# Creating Subnets Public

resource "aws_subnet" "liengesubpub" {
  count                   = length(var.cidrsubnet_pub)
  vpc_id                  = aws_vpc.liengevpc[count.index % length(aws_vpc.liengevpc)].id
  cidr_block              = var.cidrsubnet_pub[count.index]
  availability_zone       = var.azsubnet_pub[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tagsub[count.index]}"
  }
}

resource "aws_subnet" "liengesubpriv" {
  count                   = length(var.cidrsubnet_priv)
  vpc_id                  = aws_vpc.liengevpc[count.index % length(aws_vpc.liengevpc)].id
  cidr_block              = var.cidrsubnet_priv[count.index]
  availability_zone       = var.azsubnet_priv[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tagsub1[count.index]}"
  }
}
