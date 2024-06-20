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

variable "azsubnet_pub" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]

}

variable "azsubnet_priv0" {
  type    = list(string)
  default = ["us-east-1c", "us-east-1d"]

}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "ec2_instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "environment" {
  description = "The name of the environment (e.g., dev, prod)"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}