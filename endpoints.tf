# Creating an S3 Endpoint

resource "aws_vpc_endpoint" "s3_endpoint" {
    count = length(var.region)
    vpc_id = aws_vpc.liengevpc[count.index].id
    service_name = "com.amzonaws.${var.region[0]}.s3"
    vpc_endpoint_type = "Interface"

    security_group_ids = [aws_security_group.sg[count.index].id]
  
}