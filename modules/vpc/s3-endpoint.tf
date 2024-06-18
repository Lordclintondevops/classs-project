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
}