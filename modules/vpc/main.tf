# Creating our VPC's

resource "aws_vpc" "liengevpc" {
  count            = length(var.cidrvpc)
  cidr_block       = var.cidrvpc[count.index]
  instance_tenancy = var.tenancy


  tags = {
    Name = "${var.vpctags[count.index]}"
  }

}

# Creating an internet gateway

resource "aws_internet_gateway" "lienge_igw" {
  vpc_id = aws_vpc.liengevpc[0].id
}


# Creating Subnets Public

# locals {
#   subnet_cidr_blocks_priv = flatten([
#     for vpc_cidr in var.cidrvp1 :
#       [
#         cidrsubnet(vpc_cidr, 8, 2),
#         cidrsubnet(vpc_cidr, 8, 3),
#       ]
#   ])
# }

# locals {
#   vpc_cidr1           = var.cidrvpc1
#   subnet_cidr_blocks_priv = [
#     cidrsubnet(tostring(local.vpc_cidr1), 8, 2),
#     cidrsubnet(tostring(local.vpc_cidr1), 8, 3)
#     # cidrsubnet(tostring(local.vpc_cidr), 8, 4)
#   ]
# }

# locals {
#   vpc_cidr2           = var.cidrvpc2
#   subnet_cidr_blocks_priv1 = [
#     cidrsubnet(tostring(local.vpc_cidr2), 8, 2),
#     cidrsubnet(tostring(local.vpc_cidr2), 8, 3)
#     # cidrsubnet(tostring(local.vpc_cidr), 8, 4)
#   ]
# }

# locals {
#     vpc_cidr1 = "10.2.0.0/16"
#   subnet_cidr_blocks_priv = [
#     # for vpc_cidr1 in var.cidrvpc1 :
#     [
#         cidrsubnet(local.vpc_cidr1, 8, 2),
#         cidrsubnet(local.vpc_cidr1, 8, 3),
#     ]
#   ]
# }

locals {
    vpc_cidr1 = "10.2.0.0/16"
  subnet_cidr_blocks_priv = [
    cidrsubnet(local.vpc_cidr1, 8, 2),
    cidrsubnet(local.vpc_cidr1, 8, 3)
  ]

   vpc_cidr2 = "10.3.0.0/16"
  subnet_cidr_blocks_priv11 = [
    cidrsubnet(local.vpc_cidr1, 8, 4),
    cidrsubnet(local.vpc_cidr1, 8, 5)
  ]
}

# locals {
#   subnet_cidr_blocks_priv1 = flatten([
#     for vpc_cidr in var.cidrvp1 :
#       [
#         cidrsubnet(vpc_cidr, 8, 4),
#         cidrsubnet(vpc_cidr, 8, 5),
#       ]
#   ])
# }

locals {
  subnet_cidr_blocks_pub = flatten([
    for vpc_cidr in var.cidrvpc :
    [
        cidrsubnet(vpc_cidr, 8, 0),
        cidrsubnet(vpc_cidr, 8, 1),
    ]
  ])
}

resource "aws_subnet" "liengesubpub" {
  count                   = length(var.azsubnet_pub)
  vpc_id                  = aws_vpc.liengevpc[0].id
#   vpc_id                  = aws_vpc.liengevpc[count.index % length(aws_vpc.liengevpc)].id
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
#   count                   = length(var.azsubnet_priv)
#   vpc_id                  = aws_vpc.liengevpc[2].id
#   cidr_block              = local.subnet_cidr_blocks_priv1[count.index]
#   availability_zone       = var.azsubnet_priv[count.index]
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "${var.tagsub1[count.index]}"
#   }
# }

# locals {
#   subnet_cidr_blocks_priv11 = [
#     cidrsubnet(tostring(local.vpc_cidr1), 8, 4),
#     cidrsubnet(tostring(local.vpc_cidr1), 8, 5),
#     # cidrsubnet(tostring(local.vpc_cidr1), 8, 4)
#   ]
# }

# locals {
#     vpc_cidr2 = "10.3.0.0/16"
#   subnet_cidr_blocks_priv11 = [
#     # for vpc_cidr1 in var.cidrvp2 :
#     [
#         cidrsubnet(local.vpc_cidr2, 8, 4),
#         cidrsubnet(local.vpc_cidr2, 8, 5),
#     ]
#   ]
# }

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

# Creating our Route Table

resource "aws_route_table" "liengert_public" {
  count  = length(var.azsubnet_pub)
  vpc_id = aws_vpc.liengevpc[0].id

#   dynamic "route" {
#     for_each = toset([for idx, subnet in var.azsubnet_pub : idx])
#     content {
#       cidr_block = "0.0.0.0/0"
#       gateway_id = aws_internet_gateway.liengeigw.id
#       destination_cidr = "0.0.0.0/0"
#     }
#   }



  tags = {
    Name = "liengert"
  }
}

resource "aws_route" "liengert_default1" {
  route_table_id         = aws_route_table.liengert_public[count.index % length(var.azsubnet_pub)].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lienge_igw.id
#   vpc_peering_connection_id = aws_vpc_peering_connection.lienge_peering.id

  count = length(var.azsubnet_pub)
}

# resource "aws_route" "liengert_default" {
#   count = length()
#   route_table_id         = aws_route_table.liengert[count.index].id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.liengert_igw.id
# }


# Creating our Route Table No Connection

resource "aws_route_table" "liengert_private" {
  count  = length(var.azsubnet_priv0)
  vpc_id = aws_vpc.liengevpc[1].id


  tags = {
    Name = "liengert1"
  }
#   route {
#     cidr_block = "0.0.0.0/8"
#     vpc_peering_connection_id = aws_vpc_peering_connection.lienge_peering1.id
#   }
}

# resource "aws_route_table" "liengert_private1" {
#   count  = length(var.azsubnet_priv1)
#   vpc_id = "10.3.0.0/16"


#   tags = {
#     Name = "liengert1"
#   }
# }

# Associating Subnets to the route table

resource "aws_route_table_association" "liengerta" {
  count          = length(var.azsubnet_pub)
  route_table_id = aws_route_table.liengert_public[0].id
  subnet_id      = aws_subnet.liengesubpub[count.index].id

}

resource "aws_route_table_association" "liengerta1" {
  count          = length(var.azsubnet_priv0)
  route_table_id = aws_route_table.liengert_private[1].id
  subnet_id      = aws_subnet.liengesubpriv[count.index].id

}

# resource "aws_route_table_association" "liengerta2" {
#   count          = length(var.azsubnet_priv1)
#   route_table_id = aws_route_table.liengert_private1[0].id
#   subnet_id      = aws_subnet.liengesubpriv[count.index].id

# }

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

# resource "aws_route_table_association" "lienge_peeringa" {
#     count = length(var.azsubnet_pub)
#     route_table_id = aws_route_table.lienge_peering.id
#     subnet_id = aws_subnet.liengesubpub[count.index].id
  
# }

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

# resource "aws_route_table_association" "lienge_peeringa01" {
#     count = length(var.azsubnet_pub)
#     route_table_id = aws_route_table.lienge_peering01.id
#     subnet_id = aws_subnet.liengesubpriv[count.index].id
  
# }


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



# Data Source for VPC CIDR blocks
data "aws_vpc" "vpc" {
  id = aws_vpc.liengevpc[0].id
}

data "aws_vpc" "vpc1" {
  id = aws_vpc.liengevpc[1].id
}

data "aws_vpc" "vpc2" {
  id = aws_vpc.liengevpc[2].id
}

# Creating NACLs
resource "aws_network_acl" "vpc0_nacl" {
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_network_acl" "vpc1_nacl" {
  vpc_id = data.aws_vpc.vpc1.id
}

resource "aws_network_acl" "vpc2_nacl" {
  vpc_id = data.aws_vpc.vpc2.id
}

# Create NACL rules for VPC1 inbound and outbound traffic
resource "aws_network_acl_rule" "vpc1_inbound_rule" {
  network_acl_id = aws_network_acl.vpc1_nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  cidr_block     = data.aws_vpc.vpc1.cidr_block
}

resource "aws_network_acl_rule" "vpc1_outbound_rule" {
  network_acl_id = aws_network_acl.vpc1_nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  cidr_block     = data.aws_vpc.vpc2.cidr_block
}

# Create NACL rules for VPC2 inbound and outbound traffic
resource "aws_network_acl_rule" "vpc2_inbound_rule" {
  network_acl_id = aws_network_acl.vpc2_nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  cidr_block     = data.aws_vpc.vpc.cidr_block
}

resource "aws_network_acl_rule" "vpc2_outbound_rule" {
  network_acl_id = aws_network_acl.vpc2_nacl.id
  rule_number    = 100
  rule_action    = "deny"
  egress         = true
  protocol       = "-1"
  cidr_block     = data.aws_vpc.vpc.cidr_block
}

# # Associate NACLs with subnets
# resource "aws_network_acl_association" "nacl_vpc1_association" {
#   subnet_id      = aws_subnet.liengesubpub[0].id
#   network_acl_id = aws_network_acl.vpc1_nacl.id
#   depends_on      = [aws_subnet.liengesubpub[0], aws_network_acl.vpc1_nacl]
# }

# resource "aws_network_acl_association" "nacl_vpc2_association" {
#   subnet_id      = aws_subnet.liengesubpriv[0].id
#   network_acl_id = aws_network_acl.vpc2_nacl.id
#   depends_on      = [aws_subnet.liengesubpriv[0], aws_network_acl.vpc2_nacl]
# }

locals {
  vpc_count = length(aws_vpc.liengevpc)
  sg_count = length(aws_security_group.sg)
}

# Creating an S3 Endpoint

# resource "aws_vpc_endpoint" "s3_endpoint" {
#     count = length(var.region)
#     vpc_id = aws_vpc.liengevpc[count.index].id
#     service_name = "com.amzonaws.us-east-1.s3"
#     vpc_endpoint_type = "Interface"

#     security_group_ids = [aws_security_group.sg[count.index].id]
  
# }

# locals {
#   vpc_count1 = length(aws_vpc.liengevpc)
#   sg_count1  = length(aws_security_group.sg)
# }

# Creating S3 EndPoints

resource "aws_vpc_endpoint" "s3_endpoint" {
  count = length(aws_subnet.liengesubpub)
  vpc_id       = aws_vpc.liengevpc[0].id
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  policy = <<EOF
{
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]    
}
EOF

#   subnet_ids = [aws_subnet.liengesubpub.*.id[count.index]]
#   dns_enabled = true
#   dns_options {
#     dns_records {
#       type = "A"
#     }
#   }
}


# resource "aws_vpc_endpoint" "s3_endpoint" {
#   count               = local.vpc_count1 > local.sg_count1 ? local.sg_count1 : local.vpc_count1
#   vpc_id              = aws_vpc.liengevpc[count.index % local.vpc_count1].id
#   security_group_ids  = [aws_security_group.sg[count.index % local.sg_count1].id]
#   service_name        = var.service_name
# }

resource "aws_flow_log" "liengeflow" {
  count                = length(aws_vpc.liengevpc)
  vpc_id               = aws_vpc.liengevpc[count.index].id
  traffic_type         = "ALL"
  log_destination_type = "s3"

  log_destination = "arn:aws:s3:::lienge-group1"

}
# Creating an S3 Bucket

resource "aws_s3_bucket" "lienge-group1" {
  bucket = "lienge-group1"

}

# # Configuring ACL
# resource "aws_s3_bucket_acl" "liengeacl" {
#     bucket = var.bucket
#     acl = "public-read"

# }


# Creating Versioning

resource "aws_s3_bucket_versioning" "lienge-group1" {
  bucket = var.bucket

  versioning_configuration {
    status = "Enabled"
  }

}

# Creating Encryption on our bucket

resource "aws_s3_bucket_server_side_encryption_configuration" "liengecr" {
  bucket = var.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}

# Creating EC2 resources

data "aws_ami" "aws_ec2_instance" {
  most_recent = true

  owners = ["self"]

}

resource "aws_instance" "ec2pub" {
  count                  = length(var.azsubnet_pub)
  ami                    = data.aws_ami.aws_ec2_instance.id
  instance_type          = var.type
  key_name               = var.key_pair
  subnet_id              = aws_subnet.liengesubpub[count.index].id
  vpc_security_group_ids = [aws_security_group.sg[0].id]

  user_data = file("${path.module}/user_data.sh")
  tags = {
    Name = var.ec2tags[count.index]
  }
}


resource "aws_instance" "ec2priv0" {
  count                  = length(var.azsubnet_priv0)
  ami                    = data.aws_ami.aws_ec2_instance.id
  instance_type          = var.type
  key_name               = var.key_pair
  subnet_id              = aws_subnet.liengesubpriv[count.index].id
  vpc_security_group_ids = [aws_security_group.sg1[count.index].id]

  user_data = file("${path.module}/user_data.sh")
  tags = {
    Name = var.ec2tags1[count.index]
  }
}

# resource "aws_instance" "ec2priv1" {
#   count                  = length(var.azsubnet_priv1)
#   ami                    = data.aws_ami.aws_ec2_instance.id
#   instance_type          = var.type
#   key_name               = var.key_pair
#   subnet_id              = aws_subnet.liengesubpriv1[count.index].id
#   vpc_security_group_ids = [aws_security_group.sg[count.index].id]

#   user_data = file("${path.module}/user_data.sh")
#   tags = {
#     Name = var.ec2tags1[count.index]
#   }
# }