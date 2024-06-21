variable "region" {
    type = string
    default = "us-east-1"
  
}

<<<<<<< HEAD
=======
# VPC's Components



variable "cidrvpc" {
  type    = list(string)
  default = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16"]
}

variable "vpctags" {
  type    = list(string)
  default = ["transit", "database", "financial"]

}

variable "tenancy" {
  type    = string
  default = "default"

}

variable "cidrvp1" {
  type = string
  default = "10.2.0.0/16"
  
}

variable "cidrvp2" {
  type = string
  default = "10.3.0.0/16"
  
}

variable "igwcidr" {
  type    = string
  default = "0.0.0.0/0"

}

# Subnet's Components

variable "azsubnet_pub" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]

}

variable "azsubnet_priv0" {
  type    = list(string)
  default = ["us-east-1c", "us-east-1d"]

}

variable "azsubnet_priv1" {
  type    = list(string)
  default = ["us-east-1e", "us-east-1f"]

}

>>>>>>> 35b6635 (updates made)

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
<<<<<<< HEAD
# }
=======
# }

variable "tagsub" {
  type    = list(string)
  default = ["pub1", "pub2"]

}

variable "tagsub1" {
  type    = list(string)
  default = ["priv1", "priv2", "priv3", "priv4"]

}

variable "bucket" {
  type    = string
  default = "lienge-group"

}

# Security Group Components

variable "sgingress" {
  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    "22" = {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "443" = {
      port  = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "80" = {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}

variable "sgegress" {
  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    "0" = {
      port        = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]


    }
  }

}

# Components of the Transit Gateway

variable "tgwname" {
  type = string
  default = "liengetgw"
  
}

# EC2 Instance Components

variable "type" {
  type    = string
  default = "t2.micro"

}

variable "key_pair" {
  type    = string
  default = "clintontest"

}

variable "ec2tags" {
  type    = list(string)
  default = ["ecpub", "ecpub1"]

}

variable "ec2tags1" {
  type    = list(string)
  default = ["ec20", "ec21", "ec22", "ec23"]

}

>>>>>>> 35b6635 (updates made)
