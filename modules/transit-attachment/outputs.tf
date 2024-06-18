output "transit_tgw" {
    value = var.igw
  
}

output "transit_attachment_tgw" {
    value = var.tgw_vpc_id
  
}

output "transit_attachment_sbpub" {
    value = var.subnet_id_pub
  
}

output "transit_attachment_sbpriv" {
    value = var.subnet_id_priv
  
}