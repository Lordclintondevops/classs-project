locals {
    vpc_cidr1 = "10.2.0.0/16"
  subnet_cidr_blocks_priv = [
    cidrsubnet(local.vpc_cidr1, 8, 2), # 10.2.0.0/16 - 10.2.2.0/24
    cidrsubnet(local.vpc_cidr1, 8, 3)  # 10.2.0.0/16 - 10.2.3.0/24
  ]

   vpc_cidr2 = "10.3.0.0/16"
  subnet_cidr_blocks_priv11 = [
    cidrsubnet(local.vpc_cidr1, 8, 4),
    cidrsubnet(local.vpc_cidr1, 8, 5)
  ]
}

locals {
  subnet_cidr_blocks_pub = flatten([
    for vpc_cidr in var.cidrvpc :
    [
        cidrsubnet(vpc_cidr, 8, 0), # 10.1.0.0/16 - 10.1.0.0/24
        cidrsubnet(vpc_cidr, 8, 1), # 10.1.1.0/16 - 10.1.1.0/24
    ]
  ])
}

resource "aws_subnet" "liengesubpub" {
  count                   = length(var.azsubnet_pub)
  vpc_id                  = aws_vpc.liengevpc[0].id
  cidr_block              = local.subnet_cidr_blocks_pub[count.index]
  availability_zone       = var.azsubnet_pub[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tagsub[count.index]}"
  }

}

resource "aws_subnet" "liengesubpriv" {
  count                   = length(var.azsubnet_priv0)
  vpc_id                  = aws_vpc.liengevpc[1].id
  cidr_block              = local.subnet_cidr_blocks_priv[count.index]
  availability_zone       = var.azsubnet_priv0[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tagsub1[count.index]}"
  }
}

# resource "aws_subnet" "liengesubpriv1" {
#   count                   = length(var.azsubnet_priv1)
#   vpc_id                  = aws_vpc.liengevpc[2].id
#   cidr_block              = local.subnet_cidr_blocks_priv11[count.index]
#   availability_zone       = var.azsubnet_priv1[count.index]
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "${var.tagsub1[count.index]}"
#   }
# }