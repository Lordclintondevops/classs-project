# Creating an S3 Bucket

resource "aws_s3_bucket" "lienge-group" {
  bucket = "lienge_group"

}

# # Configuring ACL
# resource "aws_s3_bucket_acl" "liengeacl" {
#     bucket = var.bucket
#     acl = "public-read"

# }


# Creating Versioning

resource "aws_s3_bucket_versioning" "lienge-group1" {
  bucket = var.bucket

  versioning_configuration {
    status = "Enabled"
  }

}

# Creating Encryption on our bucket

resource "aws_s3_bucket_server_side_encryption_configuration" "liengecr" {
  bucket = var.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}