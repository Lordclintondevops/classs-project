# Security Group Components

variable "sgingress" {
  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    # "22" = {
    #   port        = 22
    #   protocol    = "tcp"
    #   cidr_blocks = ["0.0.0.0/0"]
    # }
    "443" = {
      port  = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # "80" = {
    #   port        = 80
    #   protocol    = "tcp"
    #   cidr_blocks = ["0.0.0.0/0"]
    # }
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
    "vpc1" = {
      port        = 0
      protocol    = -1
      cidr_blocks = ["10.0.0.0/8"]


    }
    "vpc2" = {
      port        = 0
      protocol    = -1
      cidr_blocks = ["10.0.0.0/8"]


    }
  }

}

variable "sgingress1" {
  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    # "22" = {
    #   port        = 22
    #   protocol    = "tcp"
    #   cidr_blocks = ["0.0.0.0/0"]
    # }
    "443" = {
      port  = 443
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
    }
    # "80" = {
    #   port        = 80
    #   protocol    = "tcp"
    #   cidr_blocks = ["0.0.0.0/0"]
    # }
  }

}

variable "sgegress1" {
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


    # }
    # "vpc1" = {
    #   port        = 0
    #   protocol    = -1
    #   cidr_blocks = ["10.1.0.0/16"]


    # }
    # "vpc2" = {
    #   port        = 0
    #   protocol    = -1
    #   cidr_blocks = ["10.2.0.0/16"]


    }
  }

}

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