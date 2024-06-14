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

# Associate NACLs with subnets
resource "aws_network_acl_association" "nacl_vpc1_association" {
  subnet_id      = aws_subnet.liengesubpub[0].id
  network_acl_id = aws_network_acl.vpc1_nacl.id
  depens_on      = [aws_subnet.liengesubpub[0], aws_network_acl.vpc1_nacl]
}

resource "aws_network_acl_association" "nacl_vpc2_association" {
  subnet_id      = aws_subnet.liengesubpriv[0].id
  network_acl_id = aws_network_acl.vpc2_nacl.id
  depens_on      = [aws_subnet.liengesubpriv[0], aws_network_acl.vpc2_nacl]
}
