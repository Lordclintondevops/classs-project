# Creating EC2 resources

data "aws_ami" "aws_ec2_instance" {
  most_recent = true

  owners = ["self"]

}

resource "aws_instance" "ec2pub" {
  count                  = length(var.azsubnet_pub)
  ami                    = data.aws_ami.aws_ec2_instance.id
  instance_type          = var.type
  key_name               = var.key_pair
  subnet_id              = aws_subnet.liengesubpub[count.index].id
  vpc_security_group_ids = [aws_security_group.sg[0].id]

  user_data = file("${path.module}/user_data.sh")
  tags = {
    Name = var.ec2tags[count.index]
  }
}


resource "aws_instance" "ec2priv0" {
  count                  = length(var.azsubnet_priv0)
  ami                    = data.aws_ami.aws_ec2_instance.id
  instance_type          = var.type
  key_name               = var.key_pair
  subnet_id              = aws_subnet.liengesubpriv[count.index].id
  vpc_security_group_ids = [aws_security_group.sg1[count.index].id]

  user_data = file("${path.module}/user_data.sh")
  tags = {
    Name = var.ec2tags1[count.index]
  }
}

# resource "aws_instance" "ec2priv1" {
#   count                  = length(var.azsubnet_priv1)
#   ami                    = data.aws_ami.aws_ec2_instance.id
#   instance_type          = var.type
#   key_name               = var.key_pair
#   subnet_id              = aws_subnet.liengesubpriv1[count.index].id
#   vpc_security_group_ids = [aws_security_group.sg[count.index].id]

#   user_data = file("${path.module}/user_data.sh")
#   tags = {
#     Name = var.ec2tags1[count.index]
#   }
# }