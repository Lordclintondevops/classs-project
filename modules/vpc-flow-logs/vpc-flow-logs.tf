# Creating a VPC flow Log

resource "aws_flow_log" "liengeflow" {
  count                = length(aws_vpc.liengevpc)
  vpc_id               = aws_vpc.liengevpc[count.index].id
  traffic_type         = "ALL"
  log_destination_type = "s3"

  log_destination = "arn:aws:s3:::lienge-group1"

}