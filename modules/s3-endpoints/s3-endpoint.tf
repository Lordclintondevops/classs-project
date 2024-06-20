# Creating S3 EndPoints for VPC2 and VPC3
resource "aws_vpc_endpoint" "s3_endpoint_vpc2" {
  vpc_id             = aws_vpc.liengevpc[1].id
  service_name       = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type  = "Gateway"

  route_table_ids = [aws_route_table.liengert_private[1].id]

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
}

resource "aws_vpc_endpoint" "s3_endpoint_vpc3" {
  vpc_id             = aws_vpc.liengevpc[2].id
  service_name       = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type  = "Gateway"

  route_table_ids = [aws_route_table.liengert_private[2].id]

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
}

# Creating Routes for S3 EndPoints
resource "aws_route" "s3_route_vpc2" {
  count                  = length(aws_route_table.liengert_private)
  route_table_id         = aws_route_table.liengert_private[count.index].id
  destination_cidr_block = var.cidrvpc[1]
  vpc_endpoint_id        = aws_vpc_endpoint.s3_endpoint_vpc2.id
  depends_on             = [aws_vpc_endpoint.s3_endpoint_vpc2]
}

resource "aws_route" "s3_route_vpc3" {
  count                  = length(aws_route_table.liengert_private)
  route_table_id         = aws_route_table.liengert_private[count.index].id
  destination_cidr_block = var.cidrvpc[2]
  vpc_endpoint_id        = aws_vpc_endpoint.s3_endpoint_vpc3.id
  depends_on             = [aws_vpc_endpoint.s3_endpoint_vpc3]
}