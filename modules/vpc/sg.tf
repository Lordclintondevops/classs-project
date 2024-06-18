# Creating a Security Group

resource "aws_security_group" "sg" {
  count  = length(var.azsubnet_priv0)
  vpc_id = aws_vpc.liengevpc[count.index % length(aws_vpc.liengevpc)].id

  dynamic "ingress" {
    for_each = var.sgingress
    content {
      to_port     = ingress.value.port
      from_port   = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.sgegress
    content {
      to_port     = egress.value.port
      from_port   = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }

  }

}

resource "aws_security_group" "sg1" {
  count  = length(var.azsubnet_priv0)
  vpc_id = aws_vpc.liengevpc[1].id

  dynamic "ingress" {
    for_each = var.sgingress
    content {
      to_port     = ingress.value.port
      from_port   = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.sgegress
    content {
      to_port     = egress.value.port
      from_port   = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }

  }

}