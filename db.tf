# # Creating our Dynamo DB Table

# resource "aws_dynamodb_table" "liengedb" {
#     name = var.db
#     billing_mode = "PAY_PER_REQUEST"
#     hash_key = "LockID"
#     attribute {
#         name = "LockID"
#         type = "S"
#     }

# }