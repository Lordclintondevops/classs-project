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
