# Security Group for S3 Endpoint
resource "aws_security_group" "s3_endpoint_sg" {
  name        = "s3-endpoint-sg"
  description = "Security group for S3 endpoint"
  vpc_id      = aws_vpc.liengevpc[0].id  # Use VPC1 ID or any VPC ID since the endpoint is for all VPCs
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow inbound HTTPS traffic from anywhere (this is for endpoint communication)
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to anywhere (S3)
  }
}