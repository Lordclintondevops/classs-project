# Creating a VPC Flow Logs

resource "aws_flow_log" "liengeflow" {
  count = length(aws_vpc.liengevpc)
  vpc_id               = aws_vpc.liengevpc[count.index].id
  traffic_type         = "ALL"
  log_destination_type = "s3"

  log_destination = aws_s3_bucket.lienge_group.bucket_arn

}

module "s3_module" {
    source = "./s3_module"
    bucket_name = "lienge_group"
  
}