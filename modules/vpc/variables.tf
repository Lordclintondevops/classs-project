variable "region" {
    type = string
    default = "us-east-1"
  
}


# variable "cidrvp1" {
#   type = list(object({
#     name = string
#   }))
  
#   default = [
#     { name = "10.2.0.0/16" },
#     { name = "10.3.0.0/16" },
#   ]
# }

# variable "cidrsubnet_pub" {
#   type    = list(string)
#   default = ["10.1.0.0/24", "10.1.1.0/24"]
# }

# variable "cidrsubnet_priv" {
#   type    = list(string)
#   default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# }