# Creating a VPC Flow Logs

resource "aws_flow_log" "liengeflow" {
  count                = length(aws_vpc.liengevpc)
  vpc_id               = aws_vpc.liengevpc[count.index].id
  traffic_type         = "ALL"
  log_destination_type = "s3"

  log_destination = aws_s3_bucket.lienge-group.id

}



# module "aws_s3_bucket" {
#   source      = "./module"
#   bucket_name = var.bucket

# }