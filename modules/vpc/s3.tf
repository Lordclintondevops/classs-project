resource "aws_s3_bucket" "lienge-group1" {
  bucket = "lienge-group1"

}

# resource "aws_s3_bucket_object" "delete_objects" {
#     bucket = "lienge-group1"
#     key = "object_key_to_delete"
#     force_destroy = true
  
# }

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