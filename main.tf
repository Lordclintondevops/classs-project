# COnfiguring the Provider

provider "aws" {
  region = var.region[0]

}

module "vpc" {
  source  = "./modules/vpcs"
  # tenancy = var.tenancy
  # cidrvpc = var.cidrvpc
}

module "subnet" {
  source  = "./modules/subnets"
  # tenancy = var.tenancy
  # cidrvpc = var.cidrvpc
}

module "igw" {
  source = "./modules/igw"
}

module "route" {
  source = "./modules/route-table"
}

module "ec2-instances" {
  source            = "./modules/ec2-instances"
  ami_id            = var.ami_id
  ec2_instance_type = var.ec2_instance_type
  subnet_ids        = [aws_subnet.liengesubpub[0].id, aws_subnet.liengesubpub[1].id]
  instance_count    = var.instance_count
}

module "s3" {
  source = "./modules/s3"
}

module "s3-endpoints" {
  source = "./modules/s3-endpoints"
}

module "security" {
  source = "./modules/security-group"
}

module "transit" {
  source = "./modules/transit"
}

module "transit-attachment" {
  source = "./modules/transit-attachment"
}

module "vpc-flow" {
  source = "./modules/vpc-flow-logs"
}













































# }
# Creating Subnets Public

# resource "aws_subnet" "liengesubpub" {
#   count                   = length(var.cidrsubnet_pub)
#   vpc_id                  = aws_vpc.liengevpc[count.index % length(aws_vpc.liengevpc)].id
#   cidr_block              = var.cidrsubnet_pub[count.index]
#   availability_zone       = var.azsubnet_pub[count.index]
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "${var.tagsub[count.index]}"
#   }
# }

# resource "aws_subnet" "liengesubpriv" {
#   count                   = length(var.cidrsubnet_priv)
#   vpc_id                  = aws_vpc.liengevpc[count.index % length(aws_vpc.liengevpc)].id
#   cidr_block              = var.cidrsubnet_priv[count.index]
#   availability_zone       = var.azsubnet_priv[count.index]
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "${var.tagsub1[count.index]}"
#   }
# }


