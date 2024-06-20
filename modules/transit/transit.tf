# Create Transit Gateway
resource "aws_ec2_transit_gateway" "tgw" {
  description = "Transit Gateway for VPC connectivity"
}