output "subnets" {
    value = aws_subnet.liengesubpub.id
  
}

output "subnet1s" {
    value = aws_subnet.liengesubpriv.id
  
}

output "sg" {
    value = aws_security_group.sg.id
  
}

output "sg1" {
    value = aws_security_group.sg1.id
  
}