variable "cidrvpc" {
  type    = list(string)
  default = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16"]
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

variable "tagsub" {
  type    = list(string)
  default = ["pub1", "pub2"]

}

variable "tagsub1" {
  type    = list(string)
  default = ["priv1", "priv2", "priv3", "priv4"]

}

