# # Creating EC2 resources

# data "aws_ami" "aws_ec2_instance" {
#   most_recent = true

#   owners = ["self"]

# }

# resource "aws_instance" "ec2priv" {
#   count                  = length(var.azsubnet_pub)
#   ami                    = data.aws_ami.aws_ec2_instance.id
#   instance_type          = var.type
#   key_name               = var.key_pair
#   subnet_id              = aws_subnet.liengesubpub[count.index].id
#   vpc_security_group_ids = [aws_security_group.sg[count.index].id]

#   user_data = file("user_data.sh")
#   tags = {
#     Name = var.ec2tags[count.index]
#   }
# }

# # data "template_file" "user_data_script" {
# #   count = length(aws_instance.ec2)

# #   template = <<-EOF
# #     #!/bin/bash
# #     if curl -sSf http://${aws_instance.ec2[count.index].public_ip}; then
# #       echo "Apache is running on ${aws_instance.ec2[count.index].public_ip}"
# #     else 
# #       echo "Apache is not running on ${aws_instance.ec2[count.index].private_ip}"
# #     fi
# #   EOF

# # }

# resource "aws_instance" "ec2" {
#   count                  = length(var.azsubnet_priv)
#   ami                    = data.aws_ami.aws_ec2_instance.id
#   instance_type          = var.type
#   key_name               = var.key_pair
#   subnet_id              = aws_subnet.liengesubpriv[count.index].id
#   vpc_security_group_ids = [aws_security_group.sg[count.index].id]

#   user_data = file("user_data.sh")
#   tags = {
#     Name = var.ec2tags[count.index]
#   }
# }